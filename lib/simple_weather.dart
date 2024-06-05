import 'package:flutter/material.dart';
import 'package:simple_weather/auth/presentation/login_page/login_page.dart';
import 'package:simple_weather/weather/data/models/weather.dart';
import 'package:simple_weather/weather/presentation/current_weather_page/current_weather_page.dart';

class SimpleWeather extends StatelessWidget {
  const SimpleWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => const LoginPage(),
      '/weather': (context) => CurrentWeatherPage(
            currentWeather: CurrentWeather(
              dt: 1622821200,
              sunrise: 1622775600,
              sunset: 1622832000,
              temp: 22,
              feelsLike: 20.3,
              pressure: 1013,
              humidity: 82,
              dewPoint: 293.15,
              clouds: 75,
              uvi: 0.0,
              visibility: 10000,
              windSpeed: 5.1,
              windGust: 7.2,
              windDeg: 220,
              rain: Precipitation(oneHour: 0.5),
              snow: null,
              weather: Weather(
                  id: 800,
                  main: 'Clear',
                  description: 'clear sky',
                  icon: '01d'),
            ),
          ),
    };

    return MaterialApp(
      title: 'SimpleWeather',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'simpleWeather',
      routes: routes,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
