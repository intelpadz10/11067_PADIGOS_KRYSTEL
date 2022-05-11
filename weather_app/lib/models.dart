class WeatherResponse {
  String iconUrl(iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
