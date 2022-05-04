// ignore_for_file: file_names

import 'package:weather/weather.dart';

class DataService {
  WeatherFactory wf = WeatherFactory('66ab015a839c71743db6df9f29ce2f08');

  Future<Weather> getWeather(String cityName) async {
    Weather data = await wf.currentWeatherByCityName(cityName);
    return data;
  }

  Future<List<Weather>> getFiveDayWeather(String cityName) async {
    List<Weather> fiveDayForecast =
        await wf.fiveDayForecastByCityName(cityName);

    return fiveDayForecast;
  }
}
