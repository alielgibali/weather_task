import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/Models/weatherForOneDay.dart';
import 'package:weather_app_task/apis/apiServices.dart';

import 'package:weather_app_task/bloc/multi_city_bloc/states.dart';
import 'package:weather_app_task/utilities/commun.dart';

class MultiWeatherEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchOneDayDataEvent extends MultiWeatherEvents {
  final String _city;
  FetchOneDayDataEvent(this._city);
  @override
  List<Object?> get props => [_city];
}

class MultiCitiesWeatherBloc
    extends Bloc<MultiWeatherEvents, MultiWeatherStates> {
  MultiCitiesWeatherBloc() : super(InitialMultiCityWeatherState());
  final ApiServices apiServices = ApiServices();
  //Cities List
  String _cities = '';
  String get cities => _cities;
  void addCity(String city) {
    _cities = city;
  }

  List<String> _allCities = [];
  void addListOfCities() {
    final split = _cities.split(',');

    for (int i = 0; i < split.length; i++) {
      _allCities.add(split[i]);
    }

    print(_allCities);
  }

// check number of Cities and clear old list
  bool isAvailable = false;
  checkAvailability() {
    _allCities = [];
    oneDayWeatherModel = [];
    addListOfCities();
    if (_allCities.length < 3 || _allCities.length > 7) {
      isAvailable = false;
    } else {
      isAvailable = true;
    }
  }

//Fetch Weather data for Multi Cities
  List<OneDayWeatherModel> oneDayWeatherModel = [];
  @override
  Stream<MultiWeatherStates> mapEventToState(MultiWeatherEvents event) async* {
    if (event is FetchOneDayDataEvent) {
      checkAvailability();
      if (isAvailable) {
        yield LoadingMultiCityWeatherState();
        try {
          for (int i = 0; i < _allCities.length; i++) {
            await apiServices.getOneDayWeather(_allCities[i]).then((value) {
              oneDayWeatherModel.add(value);
              print(value);
            });
          }
          yield MultiCityWeatherStateIsLoaded(oneDayWeatherModel);
        } catch (error) {
          yield MultiCityWeatherStateError(error);
        }
      } else {
        Commun.showToast('Invalid Number of Cities');
      }
    }
  }
}
