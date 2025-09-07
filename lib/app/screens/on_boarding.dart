import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/core/utils/constants.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});
  static const String routeName = kOnBoardingRoute;

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: OnBoardingBody(
                img: "assets/svgs/on_boarding1.svg",
                text: "Plan your world, one\ntask at a time.",
              ),
            ),
            const Spacer(),
            DotsIndicator(
              dotsCount: 4,
              position: currentPage.toDouble(),
              decorator: const DotsDecorator(
                color: Colors.grey, // Inactive color
                activeColor: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  "Skip",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 82.56,
                  height: 39.99,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key, required this.img, required this.text});
  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          img,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
        const Gap(20),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
