import 'package:weather_app_task/Models/weatherForFiveDays.dart';
import 'package:weather_app_task/Models/weatherForOneDay.dart';
import 'package:weather_app_task/apis/api_client.dart';

import 'endpoints.dart';

abstract class ApiServicesRepo {
  Future<WeatherForFiveDayesModel> getCityWeather(String cityName);
}

class ApiServices extends ApiServicesRepo {
  static const apiKey = '8978f0203b5af6cac4a88c7420320743';
  @override
  Future<WeatherForFiveDayesModel> getCityWeather(String cityName) async {
    return await getCallService(
      '${APIs.getFiveDaysWeather}$cityName&appid=$apiKey',
      RequestType.GetFiveDaysWeather,
    );
  }

  Future<OneDayWeatherModel> getOneDayWeather(String cityName) async {
    return await getCallService(
      '${APIs.getCityWeather}$cityName&appid=$apiKey',
      RequestType.GetOnedayWeather,
    );
  }
}
