import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';
import 'package:jawa_app/app/utils/ui/widgets/toast_ui.dart';

class UIToastService {
  var navkey = GlobalKey<NavigatorState>();
  Timer? _timer;
  OverlayEntry? _entry;
  final List<_ToastEntry> _queue = [];
  static final UIToastService _singleton = UIToastService._internal();

  factory UIToastService() {
    return _singleton;
  }

  UIToastService._internal();

  error({required String message, Duration? duration}) {
    _show(message: message, color: UIColors.red, duration: duration);
  }

  success({required String message, Duration? duration}) {
    _show(message: message, color: UIColors.green, duration: duration);
  }

  info({required String message, Duration? duration}) {
    _show(message: message, color: UIColors.blue, duration: duration);
  }

  warning({required String message, Duration? duration}) {
    _show(message: message, color: UIColors.orange, duration: duration);
  }

  _show({required String message, Duration? duration, required Color color}) {
    final newEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        bottom: 95.0,
        left: 24.0,
        right: 24.0,
        child: UIToast(
            message: message,
            color: color,
            duration: duration ?? Duration(seconds: 2)),
      );
    });
    _queue.add(_ToastEntry(
        entry: newEntry, duration: duration ?? Duration(seconds: 2)));
    if (_timer == null) _showOverlay();
  }

  _showOverlay() {
    if (_queue.isEmpty) {
      _entry = null;
      return;
    }
    _ToastEntry _toastEntry = _queue.removeAt(0);
    _entry = _toastEntry.entry;

    navkey.currentState!.overlay!.insert(_entry!);
    _timer = Timer(_toastEntry.duration, () {
      Future.delayed(Duration(milliseconds: 360), () {
        removeToast();
      });
    });
  }

  removeToast() {
    _timer?.cancel();
    _timer = null;
    if (_entry != null) _entry!.remove();
    _entry = null;
    _showOverlay();
  }
}

class _ToastEntry {
  final OverlayEntry? entry;
  final Duration duration;

  _ToastEntry({this.entry, required this.duration});
}
