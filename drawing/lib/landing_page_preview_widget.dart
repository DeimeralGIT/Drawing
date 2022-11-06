import 'package:drawing/fullscreen_preview.dart';
import 'package:drawing/painting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class LandingPagePreviewWidget extends StatelessWidget {
  const LandingPagePreviewWidget({
    super.key,
    required this.url,
    required this.isLetter,
  });

  final String url;
  final bool isLetter;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                isLetter ? PaintingPage(url: url) : FullscreenPreview(url: url),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          url,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
