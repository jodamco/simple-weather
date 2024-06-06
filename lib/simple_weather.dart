import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/auth/presentation/login_page/login_page.dart';
import 'package:simple_weather/core/data/repositories/token_repository.dart';
import 'package:simple_weather/core/logic/session/session_cubit.dart';
import 'package:simple_weather/core/presentation/splash_screen/splash_screen.dart';
import 'package:simple_weather/weather/presentation/current_weather_page/current_weather_page.dart';

class SimpleWeather extends StatelessWidget {
  const SimpleWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit(
        tokenRepository: TokenRepository(),
      )..initState(),
      child: const SimpleWeatherView(),
    );
  }
}

class SimpleWeatherView extends StatelessWidget {
  const SimpleWeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (_) => const SplashScreen(),
      '/login': (_) => const LoginPage(),
      '/weather': (_) => const CurrentWeatherPage()
    };

    return MaterialApp(
      title: 'SimpleWeather',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'simpleWeather',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF12711),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: routes,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
