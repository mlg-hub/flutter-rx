import 'package:weather_rxcom/json/response.dart';
class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  // final double rain;
  final double lat;
  final double lon;
  final String icon;

  WeatherModel({this.city, this.icon, this.temperature, this.description, this.lat, this.lon});
  WeatherModel.fromResponse(City response)
  : city = response.name,
  temperature = (response.main.temp * (9/5)) - 273.15,
  description = response.weather[0]?.description,
  // rain = response.rain.threeHour,
  lat = response.coord.lat,
  lon = response.coord.lon,
  icon = response.weather[0]?.icon;
}