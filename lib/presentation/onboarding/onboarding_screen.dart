import 'package:flutter/material.dart';
import 'package:zen_app/presentation/onboarding/widgets/bottom_buttons.dart';
import 'package:zen_app/presentation/onboarding/widgets/onboarding_steps.dart';

final List<OnboardingData> data = [
  OnboardingData(
    description: '1. I want...',
    localImageSrc: 'assets/images/onboarding/1.svg',
  ),
  OnboardingData(
    description: '2. My main objective is... ',
    localImageSrc: 'assets/images/onboarding/2.svg',
  ),
  OnboardingData(
    description: '3. I train...',
    localImageSrc: 'assets/images/onboarding/3.svg',
  ),
  OnboardingData(
    description: '4. Any special condition...',
    localImageSrc: 'assets/images/onboarding/4.svg',
  ),
  OnboardingData(
    description: '5. Any pains...?',
    localImageSrc: 'assets/images/onboarding/4.svg',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  int _currentIndex = 0;

  Widget createCircle({int? index}) {
    return GestureDetector(
      onTap: () => {
        setState(() => _currentIndex = index!),
        _controller.animateToPage(index!,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut)
      },
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: 100),
              margin: EdgeInsets.only(right: 10),
              height: _currentIndex == index ? 20 : 10,
              width: _currentIndex == index ? 20 : 10,
              decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.green : Colors.black,
                  borderRadius: BorderRadius.circular(10))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: height * 0.05),
                height: height * 0.7,
                child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() => _currentIndex = value);
                    },
                    children:
                        data.map((e) => OnboardingStep(data: e)).toList())),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      data.length, (index) => createCircle(index: index)),
                )),
            BottomButtons(
              currentIndex: _currentIndex,
              dataLength: data.length,
              controller: _controller,
            )
          ])),
    );
  }
}
