import 'package:flutter/material.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:summiteagle/globals/animated_widget.dart';
import 'package:summiteagle/globals/app.dart';

class BackOfficePage extends StatelessWidget with AppConfig {
  late final ScrollController _scrollController;

  BackOfficePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final double w = c.maxWidth;
        final bool isWeb = c.maxWidth > 900;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                "assets/images/image_2.png",
                fit: BoxFit.cover,
              )),
            ],
          ),
        );
      },
    );
  }
}
