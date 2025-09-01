import 'package:flutter/material.dart';

class ControllerButton extends StatefulWidget {
  const ControllerButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isPauseAndRunning,
  });
  final Widget icon;
  final VoidCallback onPressed;
  final bool isPauseAndRunning;

  @override
  State<ControllerButton> createState() => _ControllerButtonState();
}

class _ControllerButtonState extends State<ControllerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: widget.isPauseAndRunning
              ? const Color(0xFF4F46E5)
              : const Color(0xFF1F2937),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(height: 30, width: 30, child: widget.icon),
        ),
      ),
    );
  }
}
