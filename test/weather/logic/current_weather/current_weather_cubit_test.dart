import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather/core/data/models/custom_exception.dart';
import 'package:simple_weather/weather/data/interfaces/weather_provider.dart';
import 'package:simple_weather/weather/data/models/weather.dart';
import 'package:simple_weather/weather/data/providers/geo_localization_provider.dart';
import 'package:simple_weather/weather/logic/current_weather/current_weather_cubit.dart';

import 'current_weather_cubit_test.mocks.dart';

@GenerateMocks([WeatherProvider])
@GenerateMocks([GeoLocalizationProvider])
void main() {
  late CurrentWeatherCubit currentWeatherCubit;
  late MockWeatherProvider mockWeatherProvider;
  late MockGeoLocalizationProvider mockGeoLocalizationProvider;
  final testPosition = Position(
    longitude: 40.7128,
    latitude: -74.0060,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );

  setUp(() {
    mockWeatherProvider = MockWeatherProvider();
    mockGeoLocalizationProvider = MockGeoLocalizationProvider();
    currentWeatherCubit = CurrentWeatherCubit(
      weatherProvider: mockWeatherProvider,
      geoLocalProvider: mockGeoLocalizationProvider,
    );
  });

  group('CurrentWeatherCubit success cases', () {
    final testWeatherResponse = WeatherResponse.fromJson(
      {
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

    blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherData] when fetchWeatherData succeeds',
      build: () {
        when(mockGeoLocalizationProvider.getCoordinates())
            .thenAnswer((_) async => testPosition);
        when(mockWeatherProvider.fetchWeatherByCoordinates(
          lat: testPosition.latitude,
          long: testPosition.longitude,
        )).thenAnswer((_) async => testWeatherResponse);

        return currentWeatherCubit;
      },
      act: (cubit) => cubit.fetchWeatherData(),
      expect: () => [
        isA<CurrentWeatherLoading>(),
        isA<CurrentWeatherData>()
            .having(
              (p0) => p0.weather.sunset,
              "Sunset epoch time",
              (1684977332),
            )
            .having(
              (p0) => p0.weather.sunrise,
              "Sunrise epoch time",
              (1684926645),
            ),
      ],
    );
  });

  group('CurrentWeatherCubit error cases', () {
    blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherError] when location access is denied',
      build: () {
        when(mockGeoLocalizationProvider.getCoordinates())
            .thenAnswer((_) async => null);

        return currentWeatherCubit;
      },
      act: (cubit) => cubit.fetchWeatherData(),
      expect: () => [
        isA<CurrentWeatherLoading>(),
        isA<CurrentWeatherError>().having(
          (p0) => p0.errorMessage,
          "Error message from cubit",
          "No access to location",
        ),
      ],
    );
    blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherError] when ProviderException occurs',
      build: () {
        when(mockGeoLocalizationProvider.getCoordinates())
            .thenAnswer((_) async => testPosition);
        when(mockWeatherProvider.fetchWeatherByCoordinates(
          lat: testPosition.latitude,
          long: testPosition.longitude,
        )).thenThrow(ProviderException('Error fetching weather'));

        return currentWeatherCubit;
      },
      act: (cubit) => cubit.fetchWeatherData(),
      expect: () => [
        isA<CurrentWeatherLoading>(),
        isA<CurrentWeatherError>().having(
          (p0) => p0.errorMessage,
          "Error message from cubit",
          "Error fetching weather",
        ),
      ],
    );
    blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherError] when unexpected error occurs',
      build: () {
        when(mockGeoLocalizationProvider.getCoordinates())
            .thenAnswer((_) async => testPosition);
        when(mockWeatherProvider.fetchWeatherByCoordinates(
          lat: testPosition.latitude,
          long: testPosition.longitude,
        )).thenThrow(Exception('Unexpected error'));

        return currentWeatherCubit;
      },
      act: (cubit) => cubit.fetchWeatherData(),
      expect: () => [
        isA<CurrentWeatherLoading>(),
        isA<CurrentWeatherError>().having(
          (p0) => p0.errorMessage,
          "Error message from cubit",
          "Exception: Unexpected error",
        ),
      ],
    );
  });
}
