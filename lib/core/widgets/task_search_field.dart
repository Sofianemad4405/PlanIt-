import 'package:flutter/material.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/theme/app_numbers.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.isDesc = false,
    this.validator,
    this.controller,
  });
  final String hint;
  final bool prefixIcon;
  final bool isDesc;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      minLines: isDesc ? 3 : 1,
      maxLines: isDesc ? 5 : 1,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: "Roboto",
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
          borderSide: BorderSide(
            color: DarkMoodAppColors.kTextFieldBorderSideColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
          borderSide: BorderSide(
            color: DarkMoodAppColors.kTextFieldBorderSideColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
          borderSide: BorderSide(
            color: DarkMoodAppColors.kTextFieldBorderSideColor,
          ),
        ),
        hintText: hint,
        filled: true,
        fillColor: DarkMoodAppColors.kFillColor,

        hintStyle: TextStyle(color: DarkMoodAppColors.kHintColor),
        prefixIcon: prefixIcon ? Icon(Icons.search) : null,
      ),
    );
  }
}
