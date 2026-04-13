import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:planitt/core/theme/app_colors.dart';

// ─────────────────────────────────────────────
// Glass Card – main glassmorphic container
// ─────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.border,
    this.blur = 12,
    this.opacity = 0.08,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? color;
  final BoxBorder? border;
  final double blur;
  final double opacity;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(20);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            Colors.white.withValues(alpha: opacity),
                            Colors.white.withValues(alpha: opacity * 0.5),
                          ]
                        : [
                            Colors.white.withValues(alpha: 0.75),
                            Colors.white.withValues(alpha: 0.55),
                          ],
                  ),
              border: border ??
                  Border.all(
                    color: isDark
                        ? DarkMoodAppColors.kGlassStroke
                        : Colors.white.withValues(alpha: 0.6),
                    width: 1,
                  ),
              color: color,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Glass Button
// ─────────────────────────────────────────────
class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isPrimary = true,
    this.isLoading = false,
    this.width,
    this.height = 52,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isPrimary;
  final bool isLoading;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isPrimary
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF7C74FF),
                    Color(0xFF6C63FF),
                    Color(0xFF5A52E8),
                  ],
                )
              : null,
          color: isPrimary ? null : DarkMoodAppColors.kSurfaceContainer,
          border: Border.all(
            color: isPrimary
                ? Colors.white.withValues(alpha: 0.2)
                : DarkMoodAppColors.kBorderSubtle,
            width: 1,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.kAccent.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Priority Badge
// ─────────────────────────────────────────────
class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority});
  final String priority;

  @override
  Widget build(BuildContext context) {
    final (color, label) = _priorityData(priority);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _priorityData(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return (AppColors.kUrgentPriorityColor, 'URGENT');
      case 'high':
        return (AppColors.kHighPriorityColor, 'HIGH');
      case 'medium':
        return (AppColors.kMediumPriorityColor, 'MEDIUM');
      default:
        return (AppColors.kLowPriorityColor, 'LOW');
    }
  }
}

// ─────────────────────────────────────────────
// Gradient Progress Bar
// ─────────────────────────────────────────────
class GradientProgressBar extends StatelessWidget {
  const GradientProgressBar({
    super.key,
    required this.value,
    this.height = 6,
    this.backgroundColor,
  });

  final double value;
  final double height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ?? DarkMoodAppColors.kSurfaceContainer,
              borderRadius: BorderRadius.circular(height),
            ),
          ),
          FractionallySizedBox(
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height),
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C74FF), Color(0xFF6C63FF), Color(0xFF845EF7)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kAccent.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Animated Check Circle
// ─────────────────────────────────────────────
class AnimatedCheckCircle extends StatefulWidget {
  const AnimatedCheckCircle({
    super.key,
    required this.isChecked,
    required this.onToggle,
    this.size = 24,
    this.color,
  });

  final bool isChecked;
  final VoidCallback onToggle;
  final double size;
  final Color? color;

  @override
  State<AnimatedCheckCircle> createState() => _AnimatedCheckCircleState();
}

class _AnimatedCheckCircleState extends State<AnimatedCheckCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
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
    final color = widget.color ?? AppColors.kAccent;
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onToggle();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isChecked ? color : Colors.transparent,
            border: Border.all(
              color: widget.isChecked
                  ? color
                  : DarkMoodAppColors.kTextSecondary,
              width: 2,
            ),
            boxShadow: widget.isChecked
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: widget.isChecked
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
              : null,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section Header
// ─────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.count,
  });

  final String title;
  final Widget? trailing;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.kAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: AppColors.kAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        if (trailing != null) ...[
          const Spacer(),
          trailing!,
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Skeleton Loader
// ─────────────────────────────────────────────
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final double? borderRadius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            color: DarkMoodAppColors.kSurfaceContainer.withValues(
              alpha: _animation.value,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Empty State Widget
// ─────────────────────────────────────────────
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kAccent.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.kAccent.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: AppColors.kAccent, size: 36),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: DarkMoodAppColors.kTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[const SizedBox(height: 24), action!],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Gradient scaffold background
// ─────────────────────────────────────────────
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isDark) return child;
    return Stack(
      children: [
        // Ambient glow blobs
        Positioned(
          top: -120,
          right: -80,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.kAccent.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -60,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF845EF7).withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
