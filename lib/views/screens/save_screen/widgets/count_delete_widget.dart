import 'package:flutter/material.dart';

class CountDeleteWidget extends StatefulWidget {
  final Duration duration;
  const CountDeleteWidget({super.key, required this.duration});

  @override
  State<CountDeleteWidget> createState() => _CountDeleteWidgetState();
}

class _CountDeleteWidgetState extends State<CountDeleteWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  String get counterText {
    final Duration count =
        animationController.duration! * animationController.value;
    return count.inSeconds.toString();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    super.initState();
    animationController.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.white,
                value: animationController.value,
                strokeAlign: 2,
              ),
            ),
            Text(
              counterText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
