import 'package:flutter/material.dart';

class AnimatedFadeWidget extends StatefulWidget {
  const AnimatedFadeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.slideFrom = const Offset(0, 0),
  }) : super(key: key);
  final Widget child;
  final Duration duration;
  final Offset slideFrom;
  @override
  State<AnimatedFadeWidget> createState() => _AnimatedFadeWidgetState();
}

class _AnimatedFadeWidgetState extends State<AnimatedFadeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  // late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: 1,
    );
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => SlideTransition(
        position: Tween<Offset>(
          begin: widget.slideFrom,
          end: Offset.zero,
        ).animate(_controller),
        child: FadeTransition(
          opacity: _controller,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
