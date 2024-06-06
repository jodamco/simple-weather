import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/core/logic/session/session_cubit.dart';
import 'package:simple_weather/core/presentation/widgets/colorful_scaffold.dart';

import '../widgets/simple_weather_display_logo.dart';

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

    return ColorfulScaffold(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleWeatherDisplayLogo(
          animationController: _rotationController,
        ),
      ),
    );
  }
}
