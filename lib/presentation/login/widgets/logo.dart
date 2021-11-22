import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zen_app/application/auth/login_cubits/login_cubit.dart';
import 'package:zen_app/application/ui/ui_cubit.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  late final AnimationController _breathingController;
  UiCubit? _uiBloc;
  LoginCubit? _loginBloc;

  double _breath = 1.0;

  @override
  void initState() {
    super.initState();
    _uiBloc = GetIt.I<UiCubit>();
    _loginBloc = GetIt.I<LoginCubit>();

    _breathingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _uiBloc?.animationCompleted(status == AnimationStatus.dismissed);
      }
    });

    _breathingController.addListener(() {
      setState(() => _breath = _breathingController.value);
    });
    _breathingController.forward();
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _loginBloc,
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image(
              height: size.height * (0.35 + 0.05 * _breath),
              image: AssetImage('assets/images/zen_app_girl.png'),
            ),
          ],
        );
      },
    );
  }
}
