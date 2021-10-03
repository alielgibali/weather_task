import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Commun {
  static showToast(String message, {Color backGroundColor = Colors.red}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backGroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
