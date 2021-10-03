import 'package:weather_app_task/Models/weatherForFiveDays.dart';

abstract class WeatherStates {}

class InitialWeatheState extends WeatherStates {}

class LoadingState extends WeatherStates {}

class WeatherStateIsLoaded extends WeatherStates {
  final _weather;
  WeatherStateIsLoaded(this._weather);
  WeatherForFiveDayesModel get getweatherModel => _weather;
  List<Object?> get props => [_weather];
}

class WeatherError extends WeatherStates {
  final message;
  WeatherError(this.message);
}
