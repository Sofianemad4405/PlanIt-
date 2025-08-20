import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Planitt",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          SvgPicture.asset("assets/svgs/language.svg"),
          Gap(20),
          SvgPicture.asset("assets/svgs/light.svg"),
          Gap(20),
          SvgPicture.asset("assets/svgs/Settings.svg"),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
