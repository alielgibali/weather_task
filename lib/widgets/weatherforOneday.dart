import 'package:flutter/material.dart';
import 'package:weather_app_task/Models/weatherForFiveDays.dart';
import 'package:weather_app_task/Models/weather.dart';
import 'package:weather_app_task/utilities/constants.dart';
import 'package:intl/intl.dart' as intl;

class WeatherForOneDay extends StatelessWidget {
  final MainList? weatherData;
  const WeatherForOneDay({
    @required this.weatherData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .3,
          child: Text(
            intl.DateFormat('EEEE')
                .format(DateTime.parse(weatherData!.dtTxt!))
                .toString(),
            style: kSemiBoldTextStyle,
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            WeatherIconModel.getWeatherIcon(
                int.parse(weatherData!.weather![0].id!)),
            style: kSemiBoldTextStyle,
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
              '${weatherData!.main!.tempMax!.toStringAsFixed(0)}°    ${weatherData!.main!.tempMin!.toStringAsFixed(0)}°'),
        ),
      ],
    );
  }
}
