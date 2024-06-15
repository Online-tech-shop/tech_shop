import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/views/screens/save_screen/widgets/count_delete_widget.dart';

class FlushBars {
  static Flushbar<void> undo({
    required String message,
    required Duration duration,
  }) {
    return Flushbar<void>(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      icon: CountDeleteWidget(duration: duration),
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: duration,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
