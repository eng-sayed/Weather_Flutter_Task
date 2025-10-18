import '../../../../core/config/key.dart';
import '../../../../core/data_source/dio_helper.dart';
import '../../../../core/localization/localization_helper.dart';
import '../model/weather_model.dart';
import '../model/forecast_model.dart';
import 'endpoints.dart';

class WeatherRepository {
  final DioService dioService;

  WeatherRepository(this.dioService);

  Map<String, dynamic> _getCommonParams() {
    return {
      'appid': ConstKeys.weatherApiKey,
      'units': 'metric',
      'lang': LocalizationHelper.currentLocale.languageCode,
    };
  }

  Future<ApiResponse<WeatherModel?>> getCurrentWeatherByCity(
    String cityName,
  ) async {
    final response = await dioService.getData<WeatherModel>(
      url: WeatherEndpoints.currentWeather,
      query: {..._getCommonParams(), 'q': cityName},
      parser: (data) => WeatherModel.fromJson(data),
    );

    return response;
  }

  Future<ApiResponse<ForecastModel?>> getForecastByCity(String cityName) async {
    final response = await dioService.getData<ForecastModel>(
      url: WeatherEndpoints.forecast,
      query: {..._getCommonParams(), 'q': cityName},
      parser: (data) => ForecastModel.fromJson(data),
    );

    return response;
  }

  Future<ApiResponse<WeatherModel?>> searchCity(String query) async {
    return getCurrentWeatherByCity(query);
  }
}
