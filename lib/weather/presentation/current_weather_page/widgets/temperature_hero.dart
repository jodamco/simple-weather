import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/weather/data/models/weather.dart';

class TemperatureHero extends StatelessWidget {
  final CurrentWeather weather;
  const TemperatureHero({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "current temperature",
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 0.95,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 40.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                weather.temp.toStringAsFixed(0),
                style: GoogleFonts.inter(
                  fontSize: 108,
                  fontWeight: FontWeight.w500,
                  height: 0.95,
                  color: Colors.black87,
                ),
              ),
              Expanded(
                child: Text(
                  '°C',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://openweathermap.org/img/wn/${weather.weather.icon}@2x.png',
                width: 32.0,
                height: 32.0,
              ),
              Text(
                weather.weather.description,
                style: GoogleFonts.inter(
                  fontSize: 24.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
