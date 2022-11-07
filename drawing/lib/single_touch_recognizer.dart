import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MultiTouchGestureRecognizer extends MultiTapGestureRecognizer {
  late MultiTouchGestureRecognizerCallback onMultiTap;
  var numberOfTouches = 0;
  int minNumberOfTouches = 0;

  MultiTouchGestureRecognizer() {
    super.onTapDown = (pointer, details) => this.addTouch(pointer, details);
    super.onTapUp = (pointer, details) => this.removeTouch(pointer, details);
    super.onTapCancel = (pointer) => this.cancelTouch(pointer);
    super.onTap = (pointer) => this.captureDefaultTap(pointer);
  }

  void addTouch(int pointer, TapDownDetails details) {
    numberOfTouches++;
  }

  void removeTouch(int pointer, TapUpDetails details) {
    if (numberOfTouches == minNumberOfTouches) {
      onMultiTap(numberOfTouches, true);
    } else if (numberOfTouches != 0) {
      onMultiTap(numberOfTouches, false);
    }

    numberOfTouches = 0;
  }

  void cancelTouch(int pointer) {
    numberOfTouches = 0;
  }

  void captureDefaultTap(int pointer) {}

  @override
  set onTapDown(onTapDown) {}

  @override
  set onTapUp(onTapUp) {}

  @override
  set onTapCancel(onTapCancel) {}

  @override
  set onTap(onTap) {}
}

typedef MultiTouchGestureRecognizerCallback = void Function(
    int touchCount, bool correctNumberOfTouches);

class MultiTouchPage extends StatefulWidget {
  final MultiTouchPageCallback onTapCallback;
  final int minTouches;
  final Color backgroundColor;
  final Color borderColor;

  MultiTouchPage({
    required this.backgroundColor,
    required this.borderColor,
    required this.minTouches,
    required this.onTapCallback,
  });
  @override
  _MultiTouchPageState createState() => _MultiTouchPageState();
}

class _MultiTouchPageState extends State<MultiTouchPage> {
  late bool correctNumberOfTouches;
  late int touchCount;
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        MultiTouchGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<MultiTouchGestureRecognizer>(
          () => MultiTouchGestureRecognizer(),
          (MultiTouchGestureRecognizer instance) {
            instance.minNumberOfTouches = widget.minTouches;
            instance.onMultiTap = (
              touchCount,
              correctNumberOfTouches,
            ) =>
                onTap(touchCount, correctNumberOfTouches);
          },
        ),
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  border: Border(
                    top: BorderSide(width: 1.0, color: widget.borderColor),
                    left: BorderSide(width: 1.0, color: widget.borderColor),
                    right: BorderSide(width: 1.0, color: widget.borderColor),
                    bottom: BorderSide(width: 1.0, color: widget.borderColor),
                  ),
                ),
                child: Text(
                    "Tap with " + this.touchCount.toString() + " finger(s).",
                    textAlign: TextAlign.center),
              ),
            ),
          ]),
    );
  }

  void onTap(int touchCount, bool correctNumberOfTouches) {
    this.correctNumberOfTouches = correctNumberOfTouches;
    setState(() {
      this.touchCount = touchCount;
    });
    print("Tapped with " + touchCount.toString() + " finger(s)");
    widget.onTapCallback(touchCount, correctNumberOfTouches);
  }
}

typedef MultiTouchPageCallback = void Function(
    int touchCount, bool correctNumberOfTouches);
