import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/Models/weatherForFiveDays.dart';
import 'package:weather_app_task/Services/location.dart';
import 'package:weather_app_task/apis/apiServices.dart';
import 'package:weather_app_task/bloc/fiveDaysWeather/states.dart';

class WeatherEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFiveDaysDataEvent extends WeatherEvents {}

class FiveDaysWeatherBloc extends Bloc<WeatherEvents, WeatherStates> {
  FiveDaysWeatherBloc(this.apiServices) : super(InitialWeatheState());
  ApiServices apiServices;
// Get Current Location
  Location location = Location();
  Future<dynamic> getLocationWeather() async {
    await location.getCurrentLocation();
  }

//Fetch Weather data for five days
  WeatherForFiveDayesModel? weatherForFiveDayes;

  @override
  Stream<WeatherStates> mapEventToState(WeatherEvents event) async* {
    if (event is FetchFiveDaysDataEvent) {
      yield LoadingState();
      try {
        await getLocationWeather();
        await apiServices.getCityWeather(location.city!).then((value) {
          weatherForFiveDayes = value;
        });
        yield WeatherStateIsLoaded(weatherForFiveDayes);
      } catch (error) {
        yield WeatherError(error);
      }
    }
  }
}
