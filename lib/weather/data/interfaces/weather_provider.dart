import 'package:simple_weather/weather/data/models/weather.dart';

abstract class WeatherProvider {
  Future<WeatherResponse> fetchWeatherByCoordinates({
    required double lat,
    required double long,
  });
}
