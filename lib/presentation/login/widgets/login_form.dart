import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_app/application/auth/login_cubits/login_cubit.dart';
import 'package:zen_app/core/utils/constants.dart';
import 'package:zen_app/infrastructure/auth/repositories/authentication_repository.dart';
import 'package:zen_app/presentation/general/rounded_button.dart';
import 'package:zen_app/presentation/login/widgets/login_fields.dart';
import 'package:zen_app/presentation/login/widgets/social_login_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AnimationController _fadeController = AnimationController(
    duration: const Duration(milliseconds: 4500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _fadeController,
    curve: Curves.easeIn,
  );

  final FocusNode _node = FocusNode();

  LoginCubit? _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginCubit>(context);
    _fadeController.forward(from: 0.0);
    _node.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();

    super.dispose();
  }

  void _onEmailChanged(email) {
    _loginBloc?.emailChanged(email);
  }

  void _onPasswordChanged(password) {
    _loginBloc?.passwordChanged(password);
  }

  void _onFormSubmitted() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _loginBloc?.logInWithCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Logging failed')),
            );
        }
        if (state is LoginLoading) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Logging in...')),
            );
        }
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Logging success!')),
            );
          Navigator.of(context).pushNamed(homeRoute);
        }
      },
      builder: (context, state) {
        return FadeTransition(
          opacity: _animation,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginField(onChange: _onEmailChanged),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  LoginField(
                    onChange: _onPasswordChanged,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  RoundedButton(
                    text: 'Login',
                    press: _onFormSubmitted,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  SocialLoginButtons(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  GestureDetector(
                    child: Text(
                      "Don't have an account? Click here to create one",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () => Navigator.of(context).pushNamed(registerRoute),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
