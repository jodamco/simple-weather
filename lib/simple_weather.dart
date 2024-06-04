import 'package:flutter/material.dart';
import 'package:simple_weather/auth/presentation/login_page/login_page.dart';

class SimpleWeather extends StatelessWidget {
  const SimpleWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => const LoginPage(),
      '/weather': (context) =>   Scaffold(body: Container(color: Colors.black),),
    };

    return MaterialApp(
      title: 'SimpleWeather',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'simpleWeather',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
