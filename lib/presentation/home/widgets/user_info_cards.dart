import 'package:flutter/material.dart';

class UserInfoCards extends StatelessWidget {
  const UserInfoCards({
    Key? key,
    required this.icon,
    required this.info,
  }) : super(key: key);

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.07,
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.grey)),
          child: Row(
            children: [
              Icon(icon),
              Text(info),
            ],
          )),
    );
  }
}
