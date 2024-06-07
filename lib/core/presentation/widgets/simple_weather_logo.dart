import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleWeatherLogo extends StatelessWidget {
  const SimpleWeatherLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Simple Weather',
          style: GoogleFonts.montserrat(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.wb_sunny_rounded,
          color: Theme.of(context).colorScheme.onSurface,
          size: 30,
        )
      ],
    );
  }
}
