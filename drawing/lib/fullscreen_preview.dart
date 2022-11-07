import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullscreenPreview extends StatelessWidget {
  const FullscreenPreview({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: InteractiveViewer(
        minScale: 1,
        maxScale: 4,
        child: Center(
          child: Image.asset(
            url,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
