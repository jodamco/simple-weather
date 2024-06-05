import 'package:flutter/material.dart';
import 'package:simple_weather/weather/data/models/weather.dart';

import 'info_card.dart';
import 'info_stack_card.dart';
import 'temperature_hero.dart';
import 'wind_card.dart';

class WeatherDataDisplay extends StatelessWidget {
  final CurrentWeather weatherData;
  const WeatherDataDisplay({
    super.key,
    required this.weatherData,
  });

  String getHourFromEpoch(int epochValue) {
    final date = DateTime.fromMillisecondsSinceEpoch(epochValue);
    return '${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TemperatureHero(weather: weatherData),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                WindCard(
                  windDeg: weatherData.windDeg,
                  windSpeed: weatherData.windSpeed,
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
            const SizedBox(width: 8.0),
            Expanded(
              child: InfoStackCard(
                info: {
                  'Humidity': '${weatherData.humidity}%',
                  'Feels like':
                      '${weatherData.feelsLike.toStringAsFixed(0)}°C',
                  'Dew Point':
                      '${weatherData.dewPoint.toStringAsFixed(1)}°C',
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
