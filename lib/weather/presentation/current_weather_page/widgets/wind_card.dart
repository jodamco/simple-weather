import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:simple_weather/weather/presentation/current_weather_page/widgets/info_card.dart';

class WindCard extends StatelessWidget {
  final double windSpeed;
  final int windDeg;

  const WindCard({
    super.key,
    required this.windSpeed,
    required this.windDeg,
  });

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
    return InfoCard(
      data: degreeToDirection(windDeg),
      subtitle: '${(windSpeed * 3.6).toStringAsFixed(1)} km/h',
      icon: Transform.rotate(
        angle: windDeg.toDouble() * (math.pi / 180),
        child: const Icon(
          Icons.navigation,
          size: 40,
        ),
      ),
    );
  }
}
