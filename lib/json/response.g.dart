// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) =>
    new BaseResponse(
        json['message'] as String,
        json['cod'] as String,
        json['count'] as int,
        (json['list'] as List)
            ?.map((e) =>
                e == null ? null : new City.fromJson(e as Map<String, dynamic>))
            ?.toList());

abstract class _$BaseResponseSerializerMixin {
  String get message;
  String get cod;
  int get count;
  List<City> get cities;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'cod': cod,
        'count': count,
        'list': cities
      };
}

City _$CityFromJson(Map<String, dynamic> json) => new City(
    json['id'] as int,
    json['name'] as String,
    json['coord'] == null
        ? null
        : new Coord.fromJson(json['coord'] as Map<String, dynamic>),
    json['main'] == null
        ? null
        : new Main.fromJson(json['main'] as Map<String, dynamic>),
    json['dt'] as int,
    json['wind'] == null
        ? null
        : new Wind.fromJson(json['wind'] as Map<String, dynamic>),
    json['rain'] == null
        ? null
        : new Rain.fromJson(json['rain'] as Map<String, dynamic>),
    json['clouds'] == null
        ? null
        : new Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : new Weather.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$CitySerializerMixin {
  int get id;
  String get name;
  Coord get coord;
  Main get main;
  int get dt;
  Wind get wind;
  Rain get rain;
  Clouds get clouds;
  List<Weather> get weather;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'coord': coord,
        'main': main,
        'dt': dt,
        'wind': wind,
        'rain': rain,
        'clouds': clouds,
        'weather': weather
      };
}

Coord _$CoordFromJson(Map<String, dynamic> json) => new Coord(
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble());

abstract class _$CoordSerializerMixin {
  double get lat;
  double get lon;
  Map<String, dynamic> toJson() => <String, dynamic>{'lat': lat, 'lon': lon};
}

Main _$MainFromJson(Map<String, dynamic> json) => new Main(
    humidity: (json['humidity'] as num)?.toDouble(),
    pressure: (json['pressure'] as num)?.toDouble(),
    temp: (json['temp'] as num)?.toDouble(),
    tempMax: (json['temp_max'] as num)?.toDouble(),
    tempMin: (json['temp_min'] as num)?.toDouble());

abstract class _$MainSerializerMixin {
  double get temp;
  double get pressure;
  double get humidity;
  double get tempMin;
  double get tempMax;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'temp': temp,
        'pressure': pressure,
        'humidity': humidity,
        'temp_min': tempMin,
        'temp_max': tempMax
      };
}

Wind _$WindFromJson(Map<String, dynamic> json) => new Wind(
    deg: (json['deg'] as num)?.toDouble(),
    speed: (json['speed'] as num)?.toDouble(),
    gust: (json['gust'] as num)?.toDouble());

abstract class _$WindSerializerMixin {
  double get speed;
  double get deg;
  double get gust;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'speed': speed, 'deg': deg, 'gust': gust};
}

Rain _$RainFromJson(Map<String, dynamic> json) =>
    new Rain((json['threeHour'] as num)?.toDouble());

abstract class _$RainSerializerMixin {
  double get threeHour;
  Map<String, dynamic> toJson() => <String, dynamic>{'threeHour': threeHour};
}

Clouds _$CloudsFromJson(Map<String, dynamic> json) =>
    new Clouds(json['all'] as int);

abstract class _$CloudsSerializerMixin {
  int get all;
  Map<String, dynamic> toJson() => <String, dynamic>{'all': all};
}

Weather _$WeatherFromJson(Map<String, dynamic> json) => new Weather(
    (json['id'] as num)?.toDouble(),
    json['main'] as String,
    json['description'] as String,
    json['icon'] as String);

abstract class _$WeatherSerializerMixin {
  double get id;
  String get main;
  String get description;
  String get icon;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'main': main,
        'description': description,
        'icon': icon
      };
}
