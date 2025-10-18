abstract class WeatherStates {}

class WeatherInitial extends WeatherStates {}

// Current Weather States
class CurrentWeatherLoadingState extends WeatherStates {}

class CurrentWeatherSuccessState extends WeatherStates {}

class CurrentWeatherErrorState extends WeatherStates {
  final String message;
  CurrentWeatherErrorState(this.message);
}

// Forecast States
class ForecastLoadingState extends WeatherStates {}

class ForecastSuccessState extends WeatherStates {}

class ForecastErrorState extends WeatherStates {
  final String message;
  ForecastErrorState(this.message);
}

// Search States
class SearchLoadingState extends WeatherStates {}

class SearchSuccessState extends WeatherStates {}

class SearchErrorState extends WeatherStates {
  final String message;
  SearchErrorState(this.message);
}

// Favorites States
class FavoritesLoadedState extends WeatherStates {}

class FavoriteAddedState extends WeatherStates {}

class FavoriteRemovedState extends WeatherStates {}

class FavoriteErrorState extends WeatherStates {
  final String message;
  FavoriteErrorState(this.message);
}

// Refresh State
class WeatherRefreshingState extends WeatherStates {}
