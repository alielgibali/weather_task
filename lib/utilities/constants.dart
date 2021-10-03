import 'package:flutter/material.dart';

const kBoldTextStyle = TextStyle(
  fontFamily: 'Mulish-Bold',
  fontSize: 35.0,
);

const kMRegularTextStyle = TextStyle(
  fontFamily: 'Mulish',
  fontSize: 15.0,
);

const kSemiBoldTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Mulish-SemiBold',
  color: Colors.black,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    size: 30,
    color: Colors.white,
  ),
  hintText: 'Enter your City',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);
final kBackGroundDecoration = BoxDecoration(
  image: DecorationImage(
    image: const AssetImage('assets/images/weather.png'),
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
  ),
);
