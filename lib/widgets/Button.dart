import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onClick;
  final Widget? widget;
  final double? width;
  final Color? color;
  final double? height;
  const Button({
    @required this.onClick,
    @required this.widget,
    this.width,
    this.color,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: height,
        //margin: const EdgeInsets.only(top: 15),
        width: width,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            backgroundColor: color == null ? Colors.blue : color,
          ),
          onPressed: onClick,
          child: Center(
            child: widget,
          ),
        ),
      ),
    );
  }
}
