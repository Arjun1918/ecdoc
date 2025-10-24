import 'package:flutter/material.dart';

class SlideTransitionRoute {
  static Route create({
    required RouteSettings settings,
    required Widget destination,
    Duration duration = const Duration(milliseconds: 300),
    Offset begin = const Offset(1.0, 0.0), // from right to left
    Offset end = Offset.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // forward transition (push)
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        // reverse transition (pop)
        final reverseTween = Tween(begin: end, end: begin).chain(CurveTween(curve: curve));
        final reverseOffsetAnimation = secondaryAnimation.drive(reverseTween);

        return SlideTransition(
          position: offsetAnimation,
          child: SlideTransition(
            position: reverseOffsetAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }
}
