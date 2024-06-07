import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleWeatherDisplayLogo extends StatelessWidget {
  final AnimationController animationController;

  const SimpleWeatherDisplayLogo({
    super.key,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: const Icon(
            Icons.wb_sunny_rounded,
            color: Colors.white,
            size: 80,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Simple Weather',
              style: GoogleFonts.montserrat(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
