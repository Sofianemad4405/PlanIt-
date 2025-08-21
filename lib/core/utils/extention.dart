import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  /// Push a named route onto the stack.
  void push(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// Replace the current route by pushing a new named route and removing the previous one.
  void pushReplacement(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Push and remove all the previous routes until the new one.
  void pushAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pop the current route off the stack.
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Pop until the first route in the stack.
  void popUntilFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  /// Go back with a result
  void popWithResult<T>(T result) {
    Navigator.of(this).pop(result);
  }

  /// Replace all routes with a new one.
  void pushReplacementAll(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Check if can pop
  bool canPop() {
    return Navigator.of(this).canPop();
  }
}
