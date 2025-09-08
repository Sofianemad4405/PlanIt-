import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:planitt/app/controllers/language_controller.dart';
import 'package:planitt/app/controllers/theme_controller.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/theme/app_numbers.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/core/widgets/task_search_field.dart';
import 'package:planitt/root/root.dart';

class UserDataAndPreferencesScreen extends StatefulWidget {
  const UserDataAndPreferencesScreen({super.key});
  static const String routeName = kUserDataAndPreferencesScreen;

  @override
  State<UserDataAndPreferencesScreen> createState() =>
      _UserDataAndPreferencesScreenState();
}

class _UserDataAndPreferencesScreenState
    extends State<UserDataAndPreferencesScreen> {
  String selectedLanguage = "English";
  bool isNight = false;

  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const Gap(120),
                      SvgPicture.asset(
                        "assets/svgs/logo.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        "PlanIt",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                Text(
                  "Your name".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(10),
                CustomTextField(
                  hint: "Enter your name".tr(),
                  prefixIcon: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name".tr();
                    }
                    return null;
                  },
                  controller: nameController,
                ),
                const Gap(30),
                Text(
                  "Language".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(10),
                DropdownButtonFormField<String>(
                  initialValue: selectedLanguage,
                  icon: SvgPicture.asset(
                    "assets/svgs/language.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.kEight),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 0.05,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppNumbers.kEight),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 0.05,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 0.05,
                      ),
                    ),
                  ),
                  items: languages.map((l) {
                    return DropdownMenuItem(value: l, child: Text(l));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                    LanguageController.changeLanguage(
                      context,
                      selectedLanguage == "English"
                          ? const Locale("en")
                          : const Locale("ar"),
                    );
                  },
                ),
                const Gap(30),
                Text(
                  "Theme".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    SelectThemeMode(
                      img: 'assets/svgs/light.svg',
                      text: 'Light'.tr(),
                      onTap: () {
                        setState(() {
                          isNight = false;
                        });
                        context.read<ThemeCubit>().setTheme(ThemeMode.light);
                      },
                      isSelected: !isNight,
                    ),
                    const Gap(20),
                    SelectThemeMode(
                      img: "assets/svgs/night.svg",
                      text: "Night".tr(),
                      onTap: () {
                        setState(() {
                          isNight = true;
                        });
                        context.read<ThemeCubit>().setTheme(ThemeMode.dark);
                      },
                      isSelected: isNight,
                    ),
                  ],
                ),
                const Gap(50),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.read<ThemeCubit>().theme == ThemeMode.dark
                          ? Theme.of(context).inputDecorationTheme.fillColor
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppNumbers.kEight),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        PreferencesService.saveString(
                          userNameKey,
                          nameController.text,
                        );
                        PreferencesService.saveBool(kIsPreferencesSet, true);
                        context.push(Root.routeName);
                      }
                    },
                    child: Text(
                      "Next".tr(),
                      style: TextStyle(
                        color:
                            context.read<ThemeCubit>().theme == ThemeMode.dark
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectThemeMode extends StatelessWidget {
  const SelectThemeMode({
    super.key,
    required this.img,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });
  final String img;
  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 71.98,
        width: 56.12,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              img,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Text(text.tr()),
          ],
        ),
      ),
    );
  }
}
