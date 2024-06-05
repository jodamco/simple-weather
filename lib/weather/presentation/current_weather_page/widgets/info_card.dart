import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String data;
  final String subtitle;
  final Widget icon;

  const InfoCard({
    super.key,
    required this.data,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16.0),
            icon
          ],
        ),
      ),
    );
  }
}
