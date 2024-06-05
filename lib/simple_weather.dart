import 'package:flutter/material.dart';
import 'package:simple_weather/auth/presentation/login_page/login_page.dart';
import 'package:simple_weather/weather/presentation/current_weather_page/current_weather_page.dart';

class SimpleWeather extends StatelessWidget {
  const SimpleWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => const LoginPage(),
      '/weather': (context) => const CurrentWeatherPage(),
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
