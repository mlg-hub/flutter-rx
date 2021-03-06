
/*
this file is kinda like the actions 
file in a react-redux projects;
 or the services file in an angular
 project
*/

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocation/geolocation.dart';
import 'package:weather_rxcom/json/response.dart';
import 'package:weather_rxcom/models/models.dart';
import 'package:weather_rxcom/const.dart';

class WeatherRepo {
  final http.Client client;
  WeatherRepo({this.client});
  int cnt = 50;
  void addCities(int count) {
    cnt = count;
  }

  Future<List<WeatherModel>> updateWeather(LocationResult result) async {
    String url;
    if(result != null) {
      url = 'http://api.openweathermap.org/data/2.5/find?lat=${result.location.latitude}&lon=${result.location.longitude}&cnt=$cnt&appid=$ApiKey';
    }else {
      url = 'http://api.openweathermap.org/data/2.5/find?lat=43&lon=-79&cnt=10&appid=$ApiKey';
    }
    final response = await client.get(url);
    List<WeatherModel> req = BaseResponse.fromJson(json.decode(response.body))
                                        .cities
                                        .map((city){
                                          return WeatherModel.fromResponse(city);
                                        })
                                        .toList();
                                        return req;
  }

  Future<LocationResult> updateLocation() async {
    Future<LocationResult> result = Geolocation.lastKnownLocation();
    return result;
  }

  Future<bool> getGps() async {
    final GeolocationResult result = await Geolocation.isLocationOperational();
    print(result.toString());
      if(result.isSuccessful)
        return true;
      else
      return false;
  }

}