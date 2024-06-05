import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/core/logic/session/session_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SessionState _sessionState;

  late AnimationController _rotationController;

  @override
  void initState() {
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Timer(
            const Duration(milliseconds: 300),
            () => _sessionState is SessionLoggedIn
                ? Navigator.of(context).pushNamed('/weather')
                : Navigator.of(context).pushNamed('/login'),
          );
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
        const Duration(milliseconds: 200),
        () => _rotationController.forward(),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sessionState = BlocProvider.of<SessionCubit>(
      context,
    ).state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
              child: const Icon(
                Icons.wb_sunny_rounded,
                color: Color(0xFF3F3F3F),
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Simple Weather',
                  style: GoogleFonts.tinos(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3F3F3F),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
