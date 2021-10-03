import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/Models/weatherForFiveDays.dart';
import 'package:weather_app_task/Models/weather.dart';
import 'package:weather_app_task/bloc/fiveDaysWeather/getWeather.dart';
import 'package:weather_app_task/utilities/constants.dart';
import 'package:weather_app_task/widgets/weatherforOneday.dart';

class FiveDayesUi extends StatelessWidget {
  final WeatherForFiveDayesModel? weatherForFiveDayesModel;
  const FiveDayesUi({
    Key? key,
    @required this.weatherForFiveDayesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fiveDaysWeatherBloc = BlocProvider.of<FiveDaysWeatherBloc>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .1,
                  child: IconButton(
                    iconSize: 45,
                    color: Colors.white,
                    onPressed: () async {
                      fiveDaysWeatherBloc.add(FetchFiveDaysDataEvent());
                    },
                    icon: Icon(Icons.near_me),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Column(
                    children: [
                      Text(
                        '${weatherForFiveDayesModel!.city!.name}',
                        style: kBoldTextStyle,
                      ),
                      Text(
                        '${weatherForFiveDayesModel!.mainlist![0].weather![0].description} ${WeatherIconModel.getWeatherIcon(int.parse(weatherForFiveDayesModel!.mainlist![0].weather![0].id!))}',
                        style: kSemiBoldTextStyle,
                      ),
                      Text(
                        '${weatherForFiveDayesModel!.mainlist![0].main!.temp!.toStringAsFixed(0)}°',
                        style: kBoldTextStyle,
                      ),
                      Text(
                        'H:${weatherForFiveDayesModel!.mainlist![0].main!.tempMax!.toStringAsFixed(0)}° c  L:${weatherForFiveDayesModel!.mainlist![0].main!.tempMin!.toStringAsFixed(0)}° c',
                        style: kSemiBoldTextStyle,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .1,
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Divider(
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 3; i++)
                Column(
                  children: [
                    Text(weatherForFiveDayesModel!.mainlist![i].dtTxt!
                        .split(' ')
                        .last),
                    Text(
                      WeatherIconModel.getWeatherIcon(
                        int.parse(weatherForFiveDayesModel!
                            .mainlist![i].weather![0].id!),
                      ),
                    ),
                    Text(
                        '${weatherForFiveDayesModel!.mainlist![i].main!.temp!.toStringAsFixed(0)}°'),
                  ],
                ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          for (int i = 0; i < 35; i = i + 8)
            WeatherForOneDay(
              weatherData: weatherForFiveDayesModel!.mainlist![i],
            ),
        ],
      ),
    );
  }
}
