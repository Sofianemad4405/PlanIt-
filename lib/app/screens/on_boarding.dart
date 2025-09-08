import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/app/screens/user_data_and_preferences_screen.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';

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
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(200),
            Center(
              child: OnBoardingBody(
                img: currentPage == 0
                    ? "assets/svgs/on_boarding1.svg"
                    : currentPage == 1
                    ? "assets/svgs/on_boarding2.svg"
                    : currentPage == 2
                    ? "assets/svgs/on_boarding3.svg"
                    : "assets/svgs/on_boarding4.svg",
                text: currentPage == 0
                    ? "Plan your world, one\ntask at a time."
                    : currentPage == 1
                    ? "Stay focused. Stay in\ncontrol."
                    : currentPage == 2
                    ? "Turn your ideas into\nachievements."
                    : "Welcome to PlanIt.",
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (currentPage == 3) {
                        PreferencesService.saveBool(kIsOnboardingSeen, true);
                        context.pushAndRemoveUntil(
                          UserDataAndPreferencesScreen.routeName,
                        );
                      } else {
                        currentPage++;
                      }
                    });
                  },
                  child: Container(
                    width: 82.56,
                    height: 39.99,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.bold,
                        ),
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
