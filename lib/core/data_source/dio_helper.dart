import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../localization/localization_helper.dart';
import '../../shared/widgets/myLoading.dart';

class DioService {
  late final Dio _dio;

  DioService([String baseUrl = '']) {
    _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          followRedirects: true,
          headers: _getDefaultHeaders(),
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
        ),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
  }

  Map<String, dynamic> _getDefaultHeaders() {
    return {
      "Accept": "application/json",
      "lang": LocalizationHelper.currentLocale.languageCode,
    };
  }

  void _updateHeaders({required String method, bool isFile = false}) {
    _dio.options.headers = {..._getDefaultHeaders()};

    // Add Content-Type for non-GET requests
    if (method.toUpperCase() != 'GET') {
      _dio.options.headers["Content-Type"] =
          isFile ? "multipart/form-data" : "application/json";
    }
  }

  Future<ApiResponse<T?>> _request<T>({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? parser,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
  }) async {
    try {
      if (loading) MyLoading.show();

      _updateHeaders(method: method, isFile: isFile);
      final data = isForm ? FormData.fromMap(body ?? {}) : body;

      Response response = await _dio.request(
        url,
        options: Options(method: method),
        data: data,
        queryParameters: query,
      );

      if (loading) MyLoading.dismis();
      return _checkForSuccess<T?>(response, parser);
    } on DioException catch (e) {
      if (loading) MyLoading.dismis();
      return _handleDioException<T?>(e);
    } catch (e, stackTrace) {
      if (loading) MyLoading.dismis();
      log("Unhandled Error: $e", name: "dio_service_error");
      log("StackTrace: $stackTrace", name: "dio_service_error_trace");
      return ApiResponse(isError: true, model: null, message: e.toString());
    }
  }

  Future<ApiResponse<T?>> getData<T>({
    required String url,
    Map<String, dynamic>? query,
    T Function(Map<String, dynamic>)? parser,
    bool loading = false,
  }) {
    return _request<T?>(
      method: "GET",
      url: url,
      query: query,
      loading: loading,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> postData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
    T Function(Map<String, dynamic>)? parser,
  }) {
    return _request<T?>(
      method: "POST",
      url: url,
      body: body,
      query: query,
      loading: loading,
      isForm: isForm,
      isFile: isFile,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> putData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
    T Function(Map<String, dynamic>)? parser,
  }) {
    return _request<T?>(
      method: "PUT",
      url: url,
      body: body,
      query: query,
      loading: loading,
      isForm: isForm,
      isFile: isFile,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> deleteData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    T Function(Map<String, dynamic>)? parser,
    bool loading = false,
  }) {
    return _request<T?>(
      method: "DELETE",
      url: url,
      body: body,
      query: query,
      loading: loading,
      parser: parser,
    );
  }

  ApiResponse<T?> _checkForSuccess<T>(
    Response response,
    T? Function(Map<String, dynamic>)? parser,
  ) {
    // Check if response is successful
    final bool status =
        response.statusCode == 200 || response.statusCode == 201;
    final String message = response.statusMessage ?? "Success";

    try {
      if (status) {
        return ApiResponse<T?>(
          isError: false,
          response: response,
          model: (parser != null) ? parser(response.data) : null,
          message: message,
        );
      } else {
        return ApiResponse<T?>(
          isError: true,
          response: response,
          model: null,
          message: message,
        );
      }
    } catch (e, trace) {
      log("Error: $e", name: "model_error");
      log("Trace: $trace", name: "model_trace");
      return ApiResponse<T?>(
        isError: true,
        response: response,
        model: null,
        message: e.toString(),
      );
    }
  }

  ApiResponse<T?> _handleDioException<T>(DioException e) {
    String errorMessage = LocalizationHelper.tr.unexpectedError;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        errorMessage = LocalizationHelper.tr.connectionTimeout;
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            e.response?.data["message"] ?? LocalizationHelper.tr.serverError;
        break;
      case DioExceptionType.connectionError:
        errorMessage = LocalizationHelper.tr.noNetwork;
        break;
      case DioExceptionType.unknown:
        errorMessage = LocalizationHelper.tr.unknownError;
        log("DioException.unknown: ${e.message}", name: "dio_error");
        break;
      case DioExceptionType.cancel:
        errorMessage = LocalizationHelper.tr.requestCanceled;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = LocalizationHelper.tr.badCertificate;
        break;
    }

    return ApiResponse(
      isError: true,
      response: e.response,
      model: null,
      message: errorMessage,
    );
  }

  // Public method to handle DioException without internal logic
  ApiResponse<T?> handleDioException<T>(DioException e) {
    return _handleDioException<T>(e);
  }

  // Public method to handle generic errors
  ApiResponse<T?> handleGenericError<T>(Object e) {
    return ApiResponse(isError: true, model: null, message: e.toString());
  }
}

class ApiResponse<T> {
  final bool isError;
  final String? message;
  final Response? response;
  final T? model;

  ApiResponse({required this.isError, this.response, this.model, this.message});
}
