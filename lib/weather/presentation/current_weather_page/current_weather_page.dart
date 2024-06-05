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
          title: const SimpleWeatherLogo(),
        ),
        body: Padding(
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
    );
  }
}
