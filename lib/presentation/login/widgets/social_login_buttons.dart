import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zen_app/application/auth/login_cubits/login_cubit.dart';

class SocialLoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(children: [
      Container(
        child: ElevatedButton(
          onPressed: () =>
              BlocProvider.of<LoginCubit>(context).logInWithGoogle(),
          child: Container(
            width: size.width * 0.15,
            height: size.width * 0.15,
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(), primary: Colors.red),
        ),
      ),
      Container(
        child: ElevatedButton(
          onPressed: () =>
              BlocProvider.of<LoginCubit>(context).logInWithApple(),
          child: Container(
            width: size.width * 0.15,
            height: size.width * 0.15,
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.apple,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(), primary: Colors.red),
        ),
      ),
    ]);
  }
}
