import 'package:rx_command/rx_command.dart';
import 'package:geolocation/geolocation.dart';
import 'package:weather_rxcom/models/models.dart';
import 'package:weather_rxcom/weather_repo.dart';

class ModelCommand {
  final WeatherRepo weatherRepo;
  final RxCommand<Null, LocationResult> updateLocationCommand;
  final RxCommand<LocationResult, List<WeatherModel>> updateWeatherCommand;
  final RxCommand<Null, bool> getGpsCommand;
  final RxCommand<bool, bool> radioCheckedCommand;

  ModelCommand._(
      this.weatherRepo,
      this.radioCheckedCommand,
      this.updateLocationCommand,
      this.updateWeatherCommand,
      this.getGpsCommand);

  factory ModelCommand(WeatherRepo repo) {
    final _getGpsCommand = RxCommand.createAsync2<bool>(repo.getGps);

    final _radioCheckedCommand = RxCommand.createSync3<bool, bool>((b) => b);


    final _updateLocationCommand = RxCommand.createAsync2<LocationResult>
    (
      repo.updateLocation,
      canExecute: _getGpsCommand.results
    );

    final _updateWeatherCommand = RxCommand
        .createAsync3<LocationResult, List<WeatherModel>>(repo.updateWeather,
            canExecute: _radioCheckedCommand.results);

      // Logic to follow when i will have time

    // first check if the gps is available, if yes then the the radio button will follow

    /*
      if the gps is off then the switch button will be off ..hence we cant fetch data..
      if the switch is swicthed on the automatically the gps will try to be on... if the gps is false then
      we will switch back the switch to off unles we swith the gps
     */


    _updateLocationCommand.results
        .listen((data) => _updateWeatherCommand(data));
    _updateWeatherCommand(null);

    return ModelCommand._(repo, _radioCheckedCommand, _updateLocationCommand,
        _updateWeatherCommand, _getGpsCommand);
  }
}
