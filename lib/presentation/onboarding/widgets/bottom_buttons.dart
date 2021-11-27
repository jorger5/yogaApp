import 'package:flutter/material.dart';
import 'package:zen_app/core/utils/constants.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
    required this.currentIndex,
    required this.dataLength,
    required this.controller,
  }) : super(key: key);

  final int currentIndex;
  final int dataLength;
  final PageController controller;

  void onFinish(BuildContext context) {
    Navigator.pushReplacementNamed(context, loginRoute);
  }

  List<Widget> _buildFirstSteps(BuildContext context) {
    return <Widget>[
      Expanded(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 70.0,
          ),
          child: TextButton(
            onPressed: () => onFinish(context),
            child: Text('Empieza'),
          ),
        ),
      )
    ];
  }

  List<Widget> _buildLastStep(BuildContext context) {
    return <Widget>[
      TextButton(
        onPressed: () => onFinish(context),
        child: Text(
          'Omitir',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      ElevatedButton(
          onPressed: () {
            controller.nextPage(
                duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
          },
          child: Icon(Icons.arrow_right_alt))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: currentIndex == dataLength - 1
          ? _buildFirstSteps(context)
          : _buildLastStep(context),
    );
  }
}
