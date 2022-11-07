import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';

class NewPainter extends StatefulWidget {
  const NewPainter({
    super.key,
    required this.controller,
  });

  final PainterController controller;

  @override
  State<NewPainter> createState() => _NewPainterState();
}

class _NewPainterState extends State<NewPainter> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: FlutterPainter(controller: widget.controller),
    );
    ;
  }
}
