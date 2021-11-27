import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingData {
  OnboardingData({
    required this.description,
    required this.localImageSrc,
  });

  final String description;
  final String localImageSrc;
}

class OnboardingStep extends StatelessWidget {
  const OnboardingStep({
    Key? key,
    required this.data,
  }) : super(key: key);

  final OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005),
            child: Image.network(
              'https://via.placeholder.com/1300x1500?text=PlaceHolder Mientras ',
              height: MediaQuery.of(context).size.height * 0.6,
              alignment: Alignment.center,
            )
            // SvgPicture.asset(data.localImageSrc,
            //     height: MediaQuery.of(context).size.height * 0.33,
            //     alignment: Alignment.center),
            ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            data.description,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
