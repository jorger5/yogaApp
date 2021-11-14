import 'package:flutter/material.dart';
import 'package:zen_app/presentation/register/widgets/register_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: RegisterBar(), body: Container());
  }
}
