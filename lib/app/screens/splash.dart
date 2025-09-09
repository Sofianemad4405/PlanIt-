import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitt/app/screens/on_boarding.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/utils/constants.dart';
import 'package:planitt/core/utils/extention.dart';
import 'package:planitt/root/root.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale1;
  late Animation<double> _scale2;
  late Animation<double> _scale3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // كل لاير يطلع بسرعة مختلفة
    _scale1 = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _scale2 = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _scale3 = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(seconds: 2), () async {
      bool onBoardingSeen = await PreferencesService.getBool(kIsOnboardingSeen);
      if (onBoardingSeen && mounted) {
        context.push(Root.routeName);
      } else if (mounted) {
        context.push(OnBoarding.routeName);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLayer(Animation<double> animation, String asset) {
    return ScaleTransition(
      scale: animation,
      child: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildLayer(_scale1, "assets/svgs/l1.svg"),
            _buildLayer(_scale2, "assets/svgs/l2.svg"),
            _buildLayer(_scale3, "assets/svgs/l3.svg"),

            // Logo + Text
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/svgs/logo.svg",
                  height: 90,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "PlanIt",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Organize your world",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
