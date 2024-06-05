import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:simple_weather/core/data/models/custom_exception.dart';
import 'package:simple_weather/weather/data/interfaces/weather_provider.dart';
import 'package:simple_weather/weather/data/models/weather.dart';

class OpenWeatherProvider implements WeatherProvider {
  late Dio dio;

  OpenWeatherProvider({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.openweathermap.org/data/3.0/',
              ),
            );

  @override
  Future<WeatherResponse> fetchWeatherByCoordinates({
    required double lat,
    required double long,
  }) async {
    try {
      final response = await dio.get('onecall', queryParameters: {
        "lat": lat,
        'lon': long,
        'exclude': 'minutely,hourly,daily,alerts',
        'units': 'metric',
        'appid': dotenv.env['OPEN_WEATHER_APP_KEY'].toString()
      });
      return WeatherResponse.fromJson(response.data);
    } on DioException catch (error) {
      if (error.response != null) {
        throw ProviderException(error.response?.data);
      } else {
        throw ProviderException(error.message ?? "Couldn't complete API call");
      }
    } catch (_) {
      throw ProviderException("Couldn't parse response from Weather API");
    }
  }
}
