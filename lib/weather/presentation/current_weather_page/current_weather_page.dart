import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/core/presentation/widgets/simple_weather_logo.dart';
import 'package:simple_weather/weather/data/providers/geo_localization_provider.dart';
import 'package:simple_weather/weather/data/providers/open_weather_provider.dart';
import 'package:simple_weather/weather/logic/current_weather/current_weather_cubit.dart';
import 'package:simple_weather/weather/presentation/current_weather_page/widgets/empty_weather_placeholder.dart';
import 'package:simple_weather/weather/presentation/current_weather_page/widgets/loading_weather_placeholder.dart';
import 'package:simple_weather/weather/presentation/current_weather_page/widgets/weather_data.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentWeatherCubit(
        weatherProvider: OpenWeatherProvider(),
        geoLocalProvider: GeoLocalizationProvider(),
      )..fetchWeatherData(),
      child: const CurrentWeatherPageView(),
    );
  }
}

class CurrentWeatherPageView extends StatelessWidget {
  const CurrentWeatherPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentWeatherCubit, CurrentWeatherState>(
      listener: (context, state) {
        if (state is CurrentWeatherError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          flexibleSpace: Container(
            color: const Color(0xFFFDFDFD),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [SimpleWeatherLogo()],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0, 0.2, 0.6],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFF5AF19),
                  Color.fromARGB(255, 243, 212, 145),
                  Color(0xFFFDFDFD)
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
              builder: (context, state) {
                switch (state) {
                  case CurrentWeatherIdle():
                  case CurrentWeatherError():
                    return const EmptyWeatherPlaceholder();
                  case CurrentWeatherLoading():
                    return const LoadingWeatherPlaceholder();
                  case CurrentWeatherData():
                    return WeatherDataDisplay(weatherData: state.weather);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
