import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/app/controllers/language_controller.dart';
import 'package:planitt/app/controllers/theme_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      titleSpacing: 20,
      title: Text(
        "Planitt".tr(),
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => LanguageController.changeLanguage(
            context,
            LanguageController.getLocale(context) == const Locale("ar")
                ? const Locale("en")
                : const Locale("ar"),
          ),
          child: SvgPicture.asset(
            "assets/svgs/language.svg",
            colorFilter: ColorFilter.mode(
              Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const Gap(20),
        GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          child: SvgPicture.asset(
            context.read<ThemeCubit>().state == ThemeMode.dark
                ? "assets/svgs/light.svg"
                : "assets/svgs/night.svg",
            colorFilter: ColorFilter.mode(
              Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const Gap(20),
        SvgPicture.asset(
          "assets/svgs/Settings.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
            BlendMode.srcIn,
          ),
        ),
        const Gap(20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
