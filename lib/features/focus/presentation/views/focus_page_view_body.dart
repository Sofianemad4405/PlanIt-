import 'package:flutter/material.dart';

class FocusPageViewBody extends StatefulWidget {
  const FocusPageViewBody({super.key});

  @override
  State<FocusPageViewBody> createState() => _FocusPageViewBodyState();
}

class _FocusPageViewBodyState extends State<FocusPageViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("focus")]);
  }
}
