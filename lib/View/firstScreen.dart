import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/Models/weatherForOneDay.dart';
import 'package:weather_app_task/View/secondeScreen.dart';
import 'package:weather_app_task/bloc/fiveDaysWeather/getWeather.dart';
import 'package:weather_app_task/bloc/multi_city_bloc/getWeather.dart';
import 'package:weather_app_task/bloc/multi_city_bloc/states.dart';
import 'package:weather_app_task/utilities/commun.dart';
import 'package:weather_app_task/utilities/constants.dart';
import 'package:weather_app_task/widgets/Button.dart';
import 'package:weather_app_task/widgets/SearchBox.dart';

class OneDayWeatherScreen extends StatelessWidget {
  final BuildContext? ctx;
  const OneDayWeatherScreen({Key? key, this.ctx}) : super(key: key);
  void navigation(BuildContext context1) {
    Navigator.of(ctx!).push(
      MaterialPageRoute<CuurentCityScreen>(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<FiveDaysWeatherBloc>(ctx!),
          child: CuurentCityScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final oneDayWeatherBloc = BlocProvider.of<MultiCitiesWeatherBloc>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 60,
            ),
            child: Column(
              children: [
                Text(
                  'Enter Your Cities Minimum 3 and maximum 7 cities',
                  style: kSemiBoldTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SearchBox(onChanged: (city) {
                  oneDayWeatherBloc.addCity(city);
                }),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  width: MediaQuery.of(context).size.width * .7,
                  onClick: () {
                    if (oneDayWeatherBloc.cities.length > 0) {
                      oneDayWeatherBloc
                          .add(FetchOneDayDataEvent(oneDayWeatherBloc.cities));
                    } else {
                      Commun.showToast('Invalid Number of Cities');
                    }
                  },
                  widget: Text(
                    'Get Weather',
                    style: kSemiBoldTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child:
                      BlocBuilder<MultiCitiesWeatherBloc, MultiWeatherStates>(
                          builder: (context, state) {
                    if (state is InitialMultiCityWeatherState)
                      return Container();
                    else if (state is LoadingMultiCityWeatherState)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else if (state is MultiCityWeatherStateIsLoaded)
                      return Container(
                        child: Column(
                          children: [
                            ...oneDayWeatherBloc.oneDayWeatherModel
                                .map(
                                  (e) => WeatherForOneCity(
                                    weatherData: e,
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      );
                    else if (state is MultiCityWeatherStateError)
                      return Container(
                        child: Center(
                          child: Text(
                            '${state.message}',
                            style: kSemiBoldTextStyle,
                          ),
                        ),
                      );
                    else
                      return Container(
                        child: Center(
                          child: Text(
                            'Can\'t Fetch Data  Error State',
                            style: kSemiBoldTextStyle,
                          ),
                        ),
                      );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            navigation(context);
          },
        ),
      ),
    );
  }
}

class WeatherForOneCity extends StatelessWidget {
  final OneDayWeatherModel? weatherData;
  const WeatherForOneCity({
    Key? key,
    @required this.weatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            weatherData!.name!,
            style: kSemiBoldTextStyle,
          ),
        ),
        Expanded(
          child: Text(
            weatherData!.weather![0].description!,
            style: kMRegularTextStyle,
          ),
        ),
        Expanded(
          child: Text(
            weatherData!.wind!.speed!.toString(),
            style: kMRegularTextStyle,
          ),
        ),
        Expanded(
          child: Text(
            '${weatherData!.main!.tempMax!.toStringAsFixed(0)}°   ${weatherData!.main!.tempMin!.toStringAsFixed(0)}°',
            style: kMRegularTextStyle,
          ),
        ),
      ],
    );
  }
}
