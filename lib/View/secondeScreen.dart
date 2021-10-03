import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app_task/bloc/fiveDaysWeather/getWeather.dart';
import 'package:weather_app_task/bloc/fiveDaysWeather/states.dart';
import 'package:weather_app_task/utilities/constants.dart';
import 'package:weather_app_task/widgets/fiveDaysWeatherWidget.dart';

class CuurentCityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fiveDaysWeatherBloc = BlocProvider.of<FiveDaysWeatherBloc>(context);

    fiveDaysWeatherBloc.add(FetchFiveDaysDataEvent());
    return Container(
      decoration: kBackGroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          // decoration: kBackGroundDecoration,
          constraints: BoxConstraints.expand(),
          child: BlocBuilder<FiveDaysWeatherBloc, WeatherStates>(
              builder: (context, state) {
            if (state is InitialWeatheState)
              return Container(
                child: Center(
                  child: Text(
                    'Initial State',
                    style: kSemiBoldTextStyle,
                  ),
                ),
              );
            else if (state is LoadingState)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (state is WeatherStateIsLoaded)
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FiveDayesUi(
                        weatherForFiveDayesModel: state.getweatherModel,
                      ),
                    ],
                  ),
                ),
              );
            else if (state is WeatherError)
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
      ),
    );
  }
}
