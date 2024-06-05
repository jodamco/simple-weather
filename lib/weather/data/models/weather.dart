class WeatherResponse {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  CurrentWeather current;

  WeatherResponse({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: CurrentWeather.fromJson(json['current']),
    );
  }
}

class CurrentWeather {
  int dt;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  int clouds;
  double uvi;
  int visibility;
  double windSpeed;
  double windGust;
  int windDeg;
  Precipitation? rain;
  Precipitation? snow;
  Weather weather;

  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.clouds,
    required this.uvi,
    required this.visibility,
    required this.windSpeed,
    required this.windGust,
    required this.windDeg,
    this.rain,
    this.snow,
    required this.weather,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'].toDouble(),
      clouds: json['clouds'],
      uvi: json['uvi'].toDouble(),
      visibility: json['visibility'],
      windSpeed: json['wind_speed'].toDouble(),
      windGust: json['wind_gust'] != null ? json['wind_gust'].toDouble() : 0.0,
      windDeg: json['wind_deg'],
      rain: json['rain'] != null ? Precipitation.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? Precipitation.fromJson(json['snow']) : null,
      weather: (json['weather'] as List)
          .map((i) => Weather.fromJson(i))
          .toList()
          .first,
    );
  }
}

class Precipitation {
  double oneHour;

  Precipitation({required this.oneHour});

  factory Precipitation.fromJson(Map<String, dynamic> json) {
    return Precipitation(
      oneHour: json['1h'].toDouble(),
    );
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
