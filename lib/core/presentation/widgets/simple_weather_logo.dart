import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleWeatherLogo extends StatelessWidget {
  const SimpleWeatherLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Simple Weather',
          style: GoogleFonts.tinos(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3F3F3F),
          ),
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.wb_sunny_rounded,
          color: Color(0xFF3F3F3F),
          size: 30,
        )
      ],
    );
  }
}
