abstract class MultiWeatherStates {}

class InitialMultiCityWeatherState extends MultiWeatherStates {}

class LoadingMultiCityWeatherState extends MultiWeatherStates {}

class MultiCityWeatherStateIsLoaded extends MultiWeatherStates {
  final _weather;
  MultiCityWeatherStateIsLoaded(this._weather);
  get getweatherModel => _weather;
  List<Object?> get props => [_weather];
}

class MultiCityWeatherStateError extends MultiWeatherStates {
  final message;
  MultiCityWeatherStateError(this.message);
}
