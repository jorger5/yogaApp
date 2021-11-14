import 'package:flutter/material.dart';
import 'package:zen_app/core/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = circleColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  final String text;
  final Function press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      width: size.width * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: size.height * 0.07,
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: color),
            onPressed: () => press(),
            child: Text(
              text,
              style: TextStyle(color: blackColor),
            ),
          ),
        ),
      ),
    );
  }
}
