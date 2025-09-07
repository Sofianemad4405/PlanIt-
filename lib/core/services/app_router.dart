import 'package:flutter/material.dart';
import 'package:planitt/app/screens/on_boarding.dart';
import 'package:planitt/app/screens/user_data_and_preferences_screen.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/root/root.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kOnBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case kRootRoute:
        return MaterialPageRoute(builder: (_) => const Root());
      case kUserDataAndPreferencesScreen:
        return MaterialPageRoute(
          builder: (_) => const UserDataAndPreferencesScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
