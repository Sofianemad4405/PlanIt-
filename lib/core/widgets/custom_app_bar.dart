import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:planitt/app/controllers/language_controller.dart';
import 'package:planitt/app/controllers/theme_controller.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/save_or_cancel_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      titleSpacing: 20,
      title: Text(
        "PlanIt",
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
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: MediaQuery.of(context).size.height * .35,
                  width: MediaQuery.of(context).size.width * .35,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Settings".tr(),
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                          ),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            child: Row(
                              children: [
                                Text("Dark Mode".tr()),
                                const Spacer(),
                                SvgPicture.asset(
                                  context.read<ThemeCubit>().state ==
                                          ThemeMode.dark
                                      ? "assets/svgs/light.svg"
                                      : "assets/svgs/night.svg",
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor ??
                                        Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              LanguageController.changeLanguage(
                                context,
                                LanguageController.getLocale(context) ==
                                        const Locale("ar")
                                    ? const Locale("en")
                                    : const Locale("ar"),
                              );
                            },
                            child: Row(
                              children: [
                                Text("Arabic Language".tr()),
                                const Spacer(),
                                SvgPicture.asset(
                                  "assets/svgs/language.svg",
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor ??
                                        Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Follow me".tr(),
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              log("message");
                              final url = Uri.parse(
                                "https://x.com/Bojjaan_Krikc",
                              );
                              try {
                                log("sofiiii");
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                log(e.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Could not launch ${e.toString()}',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              children: [
                                Text("Twitter".tr()),
                                const Spacer(),
                                const Icon(Ionicons.logo_twitter),
                              ],
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              log("message");
                              final url = Uri.parse(
                                "https://github.com/Sofianemad4405",
                              );
                              try {
                                log("sofiiii");
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                log(e.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Could not launch ${e.toString()}',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              children: [
                                Text("Github".tr()),
                                const Spacer(),
                                const Icon(Ionicons.logo_github),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SaveOrCancelButton(
                                isCancel: false,
                                ontap: () {
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: SvgPicture.asset(
            "assets/svgs/Settings.svg",
            colorFilter: ColorFilter.mode(
              Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
