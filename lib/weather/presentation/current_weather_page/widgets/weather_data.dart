import 'package:flutter/material.dart';
import 'package:simple_weather/weather/data/models/weather.dart';
import 'dart:math' as math;

import 'info_card.dart';
import 'info_stack_card.dart';
import 'temperature_hero.dart';

class WeatherDataDisplay extends StatelessWidget {
  final CurrentWeather weatherData;
  const WeatherDataDisplay({
    super.key,
    required this.weatherData,
  });

  String getHourFromEpoch(int epochValue) {
    final date = DateTime.fromMillisecondsSinceEpoch(epochValue*1000);
    return '${date.hour}:${date.minute}';
  }

  String degreeToDirection(int degree) {
    if (degree >= 315 || degree < 45) {
      return 'North';
    } else if (degree >= 45 && degree < 135) {
      return 'East';
    } else if (degree >= 135 && degree < 225) {
      return 'South';
    } else if (degree >= 225 && degree < 315) {
      return 'West';
    } else {
      return 'Unknown'; // In case the degree is out of range, which shouldn't happen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TemperatureHero(weather: weatherData),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  InfoCard(
                    data: degreeToDirection(weatherData.windDeg),
                    subtitle:
                        '${(weatherData.windSpeed * 3.6).toStringAsFixed(1)} km/h',
                    icon: Transform.rotate(
                      angle: weatherData.windDeg.toDouble() * (math.pi / 180),
                      child: const Icon(
                        Icons.navigation,
                        size: 40,
                      ),
                    ),
                  ),
                  InfoCard(
                    data: getHourFromEpoch(weatherData.sunrise),
                    subtitle: 'Sunrise',
                    icon: const Icon(
                      Icons.wb_sunny,
                      size: 40,
                    ),
                  ),
                  InfoCard(
                    data: getHourFromEpoch(weatherData.sunset),
                    subtitle: 'Sunset',
                    icon: const Icon(
                      Icons.nights_stay_rounded,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 3,
              child: InfoStackCard(
                info: {
                  'Humidity': '${weatherData.humidity}%',
                  'Feels like': '${weatherData.feelsLike.toStringAsFixed(0)}°C',
                  'Dew Point': '${weatherData.dewPoint.toStringAsFixed(1)}°C',
                  'UV Index': '${weatherData.uvi}',
                  'Pressure': '${weatherData.pressure}hPa',
                  'Cloudiness': '${weatherData.clouds}%',
                  'Visibility': '${weatherData.visibility} m',
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
