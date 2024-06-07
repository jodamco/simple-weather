import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWeatherPlaceholder extends StatelessWidget {
  const LoadingWeatherPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 130.0,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    color: Colors.grey[300],
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
