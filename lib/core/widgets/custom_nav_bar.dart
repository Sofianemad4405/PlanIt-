import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitt/core/theme/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });
  final int currentIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.backgroundColor,
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0XFF1E2735))),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onItemTapped,
          //border from the top
          selectedItemColor: DarkMoodAppColors.kSelectedItemColor,
          unselectedItemColor: DarkMoodAppColors.kUnSelectedItemColor,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/home.svg",
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? DarkMoodAppColors.kSelectedItemColor
                      : DarkMoodAppColors.kUnSelectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/projects.svg",
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? DarkMoodAppColors.kSelectedItemColor
                      : DarkMoodAppColors.kUnSelectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Projects'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/calendar.svg",
                colorFilter: ColorFilter.mode(
                  currentIndex == 2
                      ? DarkMoodAppColors.kSelectedItemColor
                      : DarkMoodAppColors.kUnSelectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Calendar'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svgs/focus.svg",
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? DarkMoodAppColors.kSelectedItemColor
                      : DarkMoodAppColors.kUnSelectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Focus'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
