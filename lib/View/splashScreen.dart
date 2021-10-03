import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_task/View/firstScreen.dart';
import 'package:weather_app_task/bloc/multi_city_bloc/getWeather.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<MultiCitiesWeatherBloc>(context),
            child: OneDayWeatherScreen(
              ctx: context,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.blueGrey[300],
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
