import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:planitt/core/theme/app_colors.dart';

class PlanItNavBar extends StatelessWidget {
  const PlanItNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  final int currentIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: DarkMoodAppColors.kFloatingNav.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: DarkMoodAppColors.kBorderGlass,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColors.kAccent.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  outlinedIcon: Icons.home_outlined,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                _NavItem(
                  icon: Icons.folder_rounded,
                  outlinedIcon: Icons.folder_outlined,
                  label: 'Projects',
                  isSelected: currentIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                _NavItem(
                  icon: Icons.calendar_month_rounded,
                  outlinedIcon: Icons.calendar_month_outlined,
                  label: 'Calendar',
                  isSelected: currentIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                _NavItem(
                  icon: Icons.timer_rounded,
                  outlinedIcon: Icons.timer_outlined,
                  label: 'Focus',
                  isSelected: currentIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.icon,
    required this.outlinedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData outlinedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: 72,
          height: 68,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                width: 42,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? AppColors.kAccent.withValues(alpha: 0.18)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    widget.isSelected ? widget.icon : widget.outlinedIcon,
                    color: widget.isSelected
                        ? AppColors.kAccent
                        : DarkMoodAppColors.kUnSelectedItemColor,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  color: widget.isSelected
                      ? AppColors.kAccent
                      : DarkMoodAppColors.kUnSelectedItemColor,
                  fontSize: 10,
                  fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FAB - Add Task
// ─────────────────────────────────────────────
class PlanItFAB extends StatefulWidget {
  const PlanItFAB({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<PlanItFAB> createState() => _PlanItFABState();
}

class _PlanItFABState extends State<PlanItFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: RotationTransition(
          turns: _rotateAnimation,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7C74FF), Color(0xFF6C63FF), Color(0xFF5A52E8)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kAccent.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: AppColors.kAccent.withValues(alpha: 0.25),
                  blurRadius: 40,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
          ),
        ),
      ),
    ).animate().scale(
      begin: const Offset(0, 0),
      end: const Offset(1, 1),
      duration: 400.ms,
      curve: Curves.elasticOut,
      delay: 200.ms,
    );
  }
}
