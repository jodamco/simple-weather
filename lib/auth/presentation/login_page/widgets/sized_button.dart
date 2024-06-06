import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final double width;
  final bool isLoading;

  const SizedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height = 40,
    this.width = 200,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0.5,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          side: const BorderSide(
            width: 0,
            color: Colors.transparent,
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
