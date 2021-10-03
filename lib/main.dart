import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/bloc/multi_city_bloc/getWeather.dart';

import 'View/splashScreen.dart';
import 'apis/apiServices.dart';
import 'bloc/fiveDaysWeather/getWeather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MultiCitiesWeatherBloc>(
            create: (_) => MultiCitiesWeatherBloc(),
          ),
          BlocProvider<FiveDaysWeatherBloc>(
            create: (_) => FiveDaysWeatherBloc(ApiServices()),
          ),
        ],
        child: SplashScreen(),
      ),
    );
  }
}
