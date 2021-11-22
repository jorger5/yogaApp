import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:zen_app/application/auth/login_cubits/login_cubit.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginCubit = GetIt.I<LoginCubit>();
    final Size size = MediaQuery.of(context).size;
    return Row(children: [
      ElevatedButton(
        onPressed: () => _loginCubit.logInWithGoogle(),
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
      ElevatedButton(
        onPressed: () => _loginCubit.logInWithApple(),
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
    ]);
  }
}
