import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';

class UIToast extends StatefulWidget {
  UIToast({
    required this.message,
    this.fadeDuration = 350,
    required this.color,
    required this.duration,
  });

  final String message;
  final Color color;
  final Duration duration;
  final int fadeDuration;

  @override
  UIToastState createState() => UIToastState();
}

class UIToastState extends State<UIToast> with SingleTickerProviderStateMixin {
  showIt() {
    _animationController!.forward();
  }

  hideIt() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  AnimationController? _animationController;
  late Animation _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.fadeDuration),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    super.initState();

    showIt();
    _timer = Timer(widget.duration, () {
      hideIt();
    });
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation as Animation<double>,
      child: Center(
        child: Material(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              widget.message,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: UIColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
