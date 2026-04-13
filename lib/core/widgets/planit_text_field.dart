import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planitt/core/theme/app_colors.dart';

class PlanItTextField extends StatefulWidget {
  const PlanItTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.autofocus = false,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
    this.readOnly = false,
    this.onTap,
    this.filled = true,
    this.fillColor,
  });

  final TextEditingController controller;
  final String hint;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;

  @override
  State<PlanItTextField> createState() => _PlanItTextFieldState();
}

class _PlanItTextFieldState extends State<PlanItTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultFill = isDark
        ? DarkMoodAppColors.kSurfaceContainer
        : const Color(0xFFF2F2F7);

    return Focus(
      onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: AppColors.kAccent.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus,
          obscureText: widget.obscureText,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style: GoogleFonts.inter(
            color: isDark ? DarkMoodAppColors.kTextPrimary : LightMoodAppColors.kTextPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: widget.label,
            labelStyle: GoogleFonts.inter(
              color: isDark ? DarkMoodAppColors.kTextSecondary : LightMoodAppColors.kTextSecondary,
              fontSize: 14,
            ),
            filled: widget.filled,
            fillColor: widget.fillColor ?? defaultFill,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: widget.suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.prefixIcon != null ? 0 : 16,
              vertical: widget.maxLines > 1 ? 14 : 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? DarkMoodAppColors.kBorderSubtle : LightMoodAppColors.kBorderSubtle,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? DarkMoodAppColors.kBorderSubtle : LightMoodAppColors.kBorderSubtle,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.kAccent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.kRedColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.kRedColor, width: 1.5),
            ),
            hintStyle: GoogleFonts.inter(
              color: isDark ? DarkMoodAppColors.kTextTertiary : LightMoodAppColors.kUnSelectedItemColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// Search Field with cancel animation
class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.hint = 'Search tasks...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final String hint;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return PlanItTextField(
      controller: widget.controller,
      hint: widget.hint,
      onChanged: widget.onChanged,
      prefixIcon: Icon(
        Icons.search_rounded,
        color: isDark ? DarkMoodAppColors.kTextSecondary : LightMoodAppColors.kUnSelectedItemColor,
        size: 20,
      ),
      suffixIcon: _hasText
          ? IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              color: isDark ? DarkMoodAppColors.kTextSecondary : LightMoodAppColors.kUnSelectedItemColor,
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
                widget.onChanged('');
              },
            )
          : null,
    );
  }
}
