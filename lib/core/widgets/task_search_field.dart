import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planitt/core/theme/app_numbers.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.isDesc = false,
    this.validator,
    this.controller,
    this.keyboardType,
    this.onChanged,
  });
  final String hint;
  final bool prefixIcon;
  final bool isDesc;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      minLines: isDesc ? 3 : 1,
      maxLines: isDesc ? 5 : 1,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: "Roboto",
        color: Theme.of(context).colorScheme.onSurface,
      ),
      inputFormatters: keyboardType != null
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ]
          : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppNumbers.kEight),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        hintStyle: TextStyle(
          color:
              Theme.of(context).inputDecorationTheme.hintStyle?.color ??
              Colors.grey,
        ),
        prefixIcon: prefixIcon ? const Icon(Icons.search) : null,
      ),
    );
  }
}
