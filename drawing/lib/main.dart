import 'package:carousel_slider/carousel_slider.dart';
import 'package:drawing/landing_page_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Painting for Kids'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> introList = List.generate(
    3,
    (index) => LandingPagePreviewWidget(
      url: 'assets/levels/vosketar_intro_${index + 1}.png',
      isLetter: false,
    ),
  );

  List<Widget> letterList = List.generate(
    39,
    (index) => LandingPagePreviewWidget(
      url: 'assets/levels/vosketar_letter_${index + 1}.png',
      isLetter: true,
    ),
  );

  List<Widget> outroList = List.generate(
    2,
    (index) => LandingPagePreviewWidget(
      url: 'assets/levels/vosketar_outro_${index + 1}.png',
      isLetter: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: CarouselSlider(
          items: introList + letterList + outroList,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 0.7,
            aspectRatio: 1.54,
            enlargeCenterPage: true,
          ),
        ),
      ),
    );
  }
}
