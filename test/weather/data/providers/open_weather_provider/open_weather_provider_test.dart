import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather/core/data/models/custom_exception.dart';
import 'package:simple_weather/weather/data/models/weather.dart';
import 'package:simple_weather/weather/data/providers/open_weather_provider.dart';

import 'open_weather_provider_test.mocks.dart';

@GenerateMocks([Dio])
@GenerateMocks([Response])
void main() {
  late OpenWeatherProvider openWeatherProvider;
  late MockDio mockDio;
  const lat = 40.7128;
  const long = -74.0060;

  setUp(() {
    mockDio = MockDio();
    openWeatherProvider = OpenWeatherProvider(dio: mockDio);

    // Load environment variables
    dotenv.testLoad(fileInput: '''OPEN_WEATHER_APP_KEY=test_key''');
  });

  group('OpenWeatherProvider success cases', () {
    test(
        'fetchWeatherByCoordinates returns WeatherResponse on successful response',
        () async {
      final mockResponse = Response(
        statusCode: 200,
        requestOptions: RequestOptions(path: 'onecall'),
        data: {
          "lat": 33.44,
          "lon": -94.04,
          "timezone": "America/Chicago",
          "timezone_offset": -18000,
          "current": {
            "dt": 1684929490,
            "sunrise": 1684926645,
            "sunset": 1684977332,
            "temp": 292.55,
            "feels_like": 292.87,
            "pressure": 1014,
            "humidity": 89,
            "dew_point": 290.69,
            "uvi": 0.16,
            "clouds": 53,
            "visibility": 10000,
            "wind_speed": 3.13,
            "wind_deg": 93,
            "wind_gust": 6.71,
            "weather": [
              {
                "id": 803,
                "main": "Clouds",
                "description": "broken clouds",
                "icon": "04d"
              }
            ]
          }
        },
      );

      when(mockDio.get(
        "onecall",
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => mockResponse);

      final result = await openWeatherProvider.fetchWeatherByCoordinates(
        lat: lat,
        long: long,
      );

      expect(result, isA<WeatherResponse>());
    });
  });

  group('OpenWeatherProvider error cases', () {
    test(
        'fetchWeatherByCoordinates throws ProviderException on DioException with response',
        () async {
      final mockDioException = DioException(
        requestOptions: RequestOptions(path: 'onecall'),
        response: Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: 'onecall'),
          data: 'Bad Request',
        ),
      );

      when(mockDio.get("onecall", queryParameters: anyNamed('queryParameters')))
          .thenThrow(mockDioException);

      expect(
        () async => await openWeatherProvider.fetchWeatherByCoordinates(
          lat: lat,
          long: long,
        ),
        throwsA(isA<ProviderException>()),
      );
    });

    test(
        'fetchWeatherByCoordinates throws ProviderException on DioException without response',
        () async {
      final mockDioException = DioException(
        requestOptions: RequestOptions(path: 'onecall'),
        error: 'Network error',
      );

      when(mockDio.get("onecall", queryParameters: anyNamed('queryParameters')))
          .thenThrow(mockDioException);

      expect(
        () async => await openWeatherProvider.fetchWeatherByCoordinates(
          lat: lat,
          long: long,
        ),
        throwsA(isA<ProviderException>()),
      );
    });

    test(
        'fetchWeatherByCoordinates throws ProviderException on unexpected error',
        () async {
      when(mockDio.get("onecall", queryParameters: anyNamed('queryParameters')))
          .thenThrow(Exception('Unexpected error'));

      expect(
        () async => await openWeatherProvider.fetchWeatherByCoordinates(
          lat: lat,
          long: long,
        ),
        throwsA(isA<ProviderException>()),
      );
    });
  });
}
