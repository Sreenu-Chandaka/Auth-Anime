import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget child;

  SlidePageRoute(this.child)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondAnimation, Widget child) {
            final offsetAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondAnimation) {
            return child;
          },
        );
}
