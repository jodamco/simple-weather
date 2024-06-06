import 'package:flutter/material.dart';

class ColorfulScaffold extends StatelessWidget {
  final Widget child;
  const ColorfulScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              stops: [0, 1],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Color(0xFFF5AF19), Color(0xFFF12711)]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child],
        ),
      ),
    );
  }
}
