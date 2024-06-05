import 'package:flutter/material.dart';

class SizedOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final double width;
  final bool isLoading;

  const SizedOutlinedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.height = 40,
      this.width = 200,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF3F3F3F),
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          side: const BorderSide(
            width: 0.5,
            color: Color(0xFF3F3F3F),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const Center(
                child: LinearProgressIndicator(),
              )
            : child,
      ),
    );
  }
}
