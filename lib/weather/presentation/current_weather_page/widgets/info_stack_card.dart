import 'package:flutter/material.dart';

class InfoStackCard extends StatelessWidget {
  final Map<String, String> info;

  const InfoStackCard({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: info.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    entry.value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
