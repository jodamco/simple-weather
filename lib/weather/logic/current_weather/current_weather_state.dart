part of 'current_weather_cubit.dart';

@immutable
sealed class CurrentWeatherState {}

final class CurrentWeatherIdle extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherError extends CurrentWeatherState {
  final String errorMessage;
  CurrentWeatherError(this.errorMessage);
}

final class CurrentWeatherData extends CurrentWeatherState {
  final CurrentWeather weather;
  CurrentWeatherData(this.weather);
}
