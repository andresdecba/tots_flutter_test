import 'dart:ui';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    this.appBar,
    required this.body,
    super.key,
  });

  final Widget body;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Background(),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
        )
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow,
            ),
            height: 200,
            width: 200,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow,
            ),
            height: 150,
            width: 150,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
            ),
          ),
        )
      ]),
    );
  }
}
