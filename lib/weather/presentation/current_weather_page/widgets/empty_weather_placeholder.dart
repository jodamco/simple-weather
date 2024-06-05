import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWeatherPlaceholder extends StatelessWidget {
  const EmptyWeatherPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.blinds_closed,
          size: 54,
          color: Colors.black26,
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "no weather data yet",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black26),
            )
          ],
        )
      ],
    );
  }
}
