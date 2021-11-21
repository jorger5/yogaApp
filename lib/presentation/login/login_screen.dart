import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_app/application/ui/ui_cubit.dart';
import 'package:zen_app/data/auth/repositories/authentication_repository_impl.dart';
import 'package:zen_app/presentation/login/widgets/login_form.dart';
import 'package:zen_app/presentation/login/widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationRepositoryImpl? _authenticationRepository =
      AuthenticationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<UiCubit, UiState>(
        builder: (context, state) {
          print(state);
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedPositioned(
                top: state.animationCompleted
                    ? size.height * 0.1
                    : size.height * 0.25,
                child: Center(child: Logo()),
                duration: const Duration(milliseconds: 750),
              ),
              AnimatedPositioned(
                top: state.animationCompleted ? size.height * 0.5 : size.height,
                child: Center(
                  child: LoginForm(
                    authenticationRepository: _authenticationRepository!,
                  ),
                ),
                duration: const Duration(milliseconds: 750),
              )
            ],
          );
        },
      ),
    );
  }
}
