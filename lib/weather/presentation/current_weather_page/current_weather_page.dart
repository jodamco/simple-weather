import 'package:flutter/material.dart';
import 'package:simple_weather/core/presentation/widgets/simple_weather_logo.dart';
import 'package:simple_weather/weather/data/models/weather.dart';

import 'widgets/info_card.dart';
import 'widgets/info_stack_card.dart';
import 'widgets/temperature_hero.dart';
import 'widgets/wind_card.dart';

class CurrentWeatherPage extends StatelessWidget {
  final CurrentWeather currentWeather;

  const CurrentWeatherPage({super.key, required this.currentWeather});

  String getHourFromEpoch(int epochValue) {
    final date = DateTime.fromMillisecondsSinceEpoch(epochValue);
    return '${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SimpleWeatherLogo(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemperatureHero(weather: currentWeather),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    WindCard(
                      windDeg: currentWeather.windDeg,
                      windSpeed: currentWeather.windSpeed,
                    ),
                    InfoCard(
                      data: getHourFromEpoch(currentWeather.sunrise),
                      subtitle: 'Sunrise',
                      icon: const Icon(
                        Icons.wb_sunny,
                        size: 40,
                      ),
                    ),
                    InfoCard(
                      data: getHourFromEpoch(currentWeather.sunset),
                      subtitle: 'Sunset',
                      icon: const Icon(
                        Icons.nights_stay_rounded,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: InfoStackCard(
                    info: {
                      'Humidity': '${currentWeather.humidity}%',
                      'Feels like':
                          '${currentWeather.feelsLike.toStringAsFixed(0)}°C',
                      'Dew Point':
                          '${currentWeather.dewPoint.toStringAsFixed(1)}°C',
                      'UV Index': '${currentWeather.uvi}',
                      'Pressure': '${currentWeather.pressure}hPa',
                      'Cloudiness': '${currentWeather.clouds}%',
                      'Visibility': '${currentWeather.visibility} m',
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
