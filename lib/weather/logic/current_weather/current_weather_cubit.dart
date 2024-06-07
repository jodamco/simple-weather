import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_weather/core/data/models/custom_exception.dart';
import 'package:simple_weather/weather/data/interfaces/weather_provider.dart';
import 'package:simple_weather/weather/data/models/weather.dart';
import 'package:simple_weather/weather/data/providers/geo_localization_provider.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  final WeatherProvider weatherProvider;
  final GeoLocalizationProvider geoLocalProvider;

  CurrentWeatherCubit({
    required this.weatherProvider,
    required this.geoLocalProvider,
  }) : super(CurrentWeatherIdle());

  Future<void> fetchWeatherData() async {
    try {
      emit(CurrentWeatherLoading());

      final coordinates = await geoLocalProvider.getCoordinates();

      if (coordinates == null) {
        emit(CurrentWeatherError("No access to location"));
        return;
      }

      final weatherData = await weatherProvider.fetchWeatherByCoordinates(
        lat: coordinates.latitude,
        long: coordinates.longitude,
      );

      final currentWeather = weatherData.current;

      emit(CurrentWeatherData(currentWeather));
    } on ProviderException catch (error) {
      emit(CurrentWeatherError(error.message));
    } catch (error) {
      emit(CurrentWeatherError(error.toString()));
    }
  }
}
