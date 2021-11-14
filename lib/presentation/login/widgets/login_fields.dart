import 'package:flutter/material.dart';
import 'package:zen_app/core/utils/constants.dart';

class LoginField extends StatefulWidget {
  const LoginField({
    Key? key,
    required this.onChange,
    this.isPassword = false,
  }) : super(key: key);

  final Function onChange;
  final bool isPassword;

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  late final TextEditingController textEditingController;
  final FocusNode _node = FocusNode();
  bool _isHidden = true;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController
        .addListener(() => widget.onChange(textEditingController.text));
    _node.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    void _toggleVisibility() {
      setState(() => _isHidden = !_isHidden);
    }

    return Container(
      width: size.width * 0.9,
      child: TextFormField(
        focusNode: _node,
        controller: textEditingController,
        key: widget.isPassword ? Key('loginPassword') : Key('loginEmail'),
        autocorrect: false,
        obscureText: widget.isPassword ? _isHidden : widget.isPassword,
        decoration: InputDecoration(
          labelText: widget.isPassword ? 'Password' : 'Email',
          labelStyle: TextStyle(color: _node.hasFocus ? redColor : blackColor),
          prefixIcon: widget.isPassword
              ? Icon(
                  Icons.lock,
                  color: _node.hasFocus ? redColor : blackColor,
                )
              : Icon(
                  Icons.mail,
                  color: _node.hasFocus ? redColor : blackColor,
                ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: _node.hasFocus ? redColor : blackColor,
                  ),
                  onPressed: () {
                    _toggleVisibility();
                  },
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: blackColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: redColor,
            ),
          ),
        ),
      ),
    );
  }
}
