import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_flutter/core/utils/locator.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/localization/localization_helper.dart';
import '../../../core/services/alerts.dart';
import '../domain/model/favorite_city_model.dart';
import '../domain/model/forecast_model.dart';
import '../domain/model/weather_model.dart';
import '../domain/repository/weather_repository.dart';
import 'weather_states.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(CurrentWeatherLoadingState());

  static WeatherCubit get(context) => BlocProvider.of(context);

  final WeatherRepository _weatherRepository = locator<WeatherRepository>();

  WeatherModel? currentWeather;
  ForecastModel? forecast;
  List<FavoriteCityModel> favorites = [];

  List<WeatherModel> searchResults = [];
  Timer? _searchDebounce;

  static const String _favoritesBoxName = 'weather_favorites';
  static const int _maxFavorites = 5;

  Future<void> init() async {
    await loadFavorites();
  }

  Future<void> getCurrentWeather(String cityName) async {
    emit(CurrentWeatherLoadingState());

    final response = await _weatherRepository.getCurrentWeatherByCity(cityName);

    if (response.isError == false && response.model != null) {
      currentWeather = response.model;
      emit(CurrentWeatherSuccessState());

      await getForecast(cityName);
    } else {
      emit(
        CurrentWeatherErrorState(
          response.message ?? 'Failed to fetch weather data',
        ),
      );
      Alerts.snack(
        text: response.message ?? 'Failed to fetch weather data',
        state: SnackState.failed,
      );
    }
  }

  Future<void> getForecast(String cityName) async {
    emit(ForecastLoadingState());

    final response = await _weatherRepository.getForecastByCity(cityName);

    if (response.isError == false && response.model != null) {
      forecast = response.model;
      emit(ForecastSuccessState());
    } else {
      emit(
        ForecastErrorState(
          response.message ?? LocalizationHelper.tr.failedToFetchForecast,
        ),
      );
    }
  }

  Future<void> searchCity(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      emit(SearchSuccessState());
      return;
    }

    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchLoadingState());

      final response = await _weatherRepository.searchCity(query);

      if (response.isError == false && response.model != null) {
        searchResults = [response.model!];
        emit(SearchSuccessState());
      } else {
        searchResults.clear();
        emit(
          SearchErrorState(
            response.message ?? LocalizationHelper.tr.cityNotFound,
          ),
        );
      }
    });
  }

  void clearSearch() {
    searchResults.clear();
    emit(SearchSuccessState());
  }

  Future<void> refreshWeather() async {
    if (currentWeather != null) {
      emit(WeatherRefreshingState());
      await getCurrentWeather(currentWeather!.cityName);
    }
  }

  Future<void> loadFavorites() async {
    try {
      final box = await Hive.openBox<FavoriteCityModel>(_favoritesBoxName);
      favorites = box.values.toList();
    } catch (e) {
      emit(FavoriteErrorState('Failed to load favorites'));
    }
  }

  Future<bool> addToFavorites(WeatherModel weather) async {
    try {
      // Check if already in favorites
      if (isFavorite(weather.cityName)) {
        Alerts.snack(
          text: LocalizationHelper.tr.cityAlreadyInFavorites,
          state: SnackState.failed,
        );
        return false;
      }

      // Check max limit
      if (favorites.length >= _maxFavorites) {
        Alerts.snack(
          text: LocalizationHelper.tr.maxFavoritesReached,
          state: SnackState.failed,
        );
        emit(FavoriteErrorState(LocalizationHelper.tr.maxFavoritesReached));
        return false;
      }

      final box = await Hive.openBox<FavoriteCityModel>(_favoritesBoxName);

      final favoriteCity = FavoriteCityModel(
        cityName: weather.cityName,
        countryCode: weather.countryCode,
        lat: weather.lat,
        lon: weather.lon,
        addedAt: DateTime.now(),
      );

      await box.add(favoriteCity);
      favorites = box.values.toList();

      emit(FavoriteAddedState());
      Alerts.snack(
        text: LocalizationHelper.tr.addedToFavorites,
        state: SnackState.success,
      );

      return true;
    } catch (e) {
      emit(FavoriteErrorState(LocalizationHelper.tr.failedToAddFavorite));
      Alerts.snack(
        text: LocalizationHelper.tr.failedToAddFavorite,
        state: SnackState.failed,
      );
      return false;
    }
  }

  Future<void> removeFromFavorites(FavoriteCityModel city) async {
    try {
      final box = await Hive.openBox<FavoriteCityModel>(_favoritesBoxName);

      final key = box.keys.firstWhere((key) {
        final item = box.get(key);
        return item?.cityName == city.cityName &&
            item?.countryCode == city.countryCode;
      }, orElse: () => null);

      if (key != null) {
        await box.delete(key);
        favorites = box.values.toList();

        emit(FavoriteRemovedState());
        Alerts.snack(
          text: LocalizationHelper.tr.removedFromFavorites,
          state: SnackState.success,
        );
      }
    } catch (e) {
      emit(FavoriteErrorState(LocalizationHelper.tr.failedToRemoveFavorite));
      Alerts.snack(
        text: LocalizationHelper.tr.failedToRemoveFavorite,
        state: SnackState.failed,
      );
    }
  }

  bool isFavorite(String cityName) {
    return favorites.any(
      (city) => city.cityName.toLowerCase() == cityName.toLowerCase(),
    );
  }

  Future<void> selectFavoriteCity(FavoriteCityModel city) async {
    await getCurrentWeather(city.cityName);
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
