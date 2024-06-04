import 'package:flutter/material.dart';
import 'package:simple_weather/simple_weather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const SimpleWeather(),
  );
}
