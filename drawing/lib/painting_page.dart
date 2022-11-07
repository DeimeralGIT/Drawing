import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'painter.dart';

class PaintingPage extends StatefulWidget {
  const PaintingPage({
    super.key,
    required this.url,
  });

  @override
  PaintingPageState createState() => PaintingPageState();

  final String url;
}

class PaintingPageState extends State<PaintingPage> {
  final PainterController _controller = controller();

  @override
  void initState() {
    super.initState();
  }

  static PainterController controller() {
    PainterController controller = PainterController();
    controller.thickness = 1.0;
    controller.backgroundColor = Colors.transparent;
    controller.drawColor = Colors.green;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    // if (_finished) {
    //   actions = <Widget>[
    //     IconButton(
    //       icon: const Icon(Icons.content_copy),
    //       color: Colors.blue.shade900,
    //       tooltip: 'New Painting',
    //       onPressed: () => setState(() {
    //         _finished = false;
    //         _controller = controller();
    //       }),
    //     ),
    //   ];
    // }
    actions = <Widget>[
      IconButton(
          icon: const Icon(
            Icons.undo,
          ),
          tooltip: 'Undo',
          color: Colors.blue.shade900,
          onPressed: () {
            if (!_controller.isEmpty) {
              _controller.undo();
            }
          }),
      IconButton(
        icon: const Icon(Icons.delete),
        tooltip: 'Clear',
        color: Colors.blue.shade900,
        onPressed: _controller.clear,
      ),
      // IconButton(
      //     icon: const Icon(Icons.check),
      //     onPressed: () => _show(_controller.finish(), context)),
    ];

    TransformationController _zoomTransformationController =
        TransformationController();

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
          title: const Text('Painting for Kids'),
          foregroundColor: Colors.blue.shade900,
          actions: actions,
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 30.0),
            child: DrawBar(_controller),
          )),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.url),
          ),
        ),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Painter(_controller),
            ),
          ),
        ),
      ),
    );
  }

  // void _show(PictureDetails picture, BuildContext context) {
  //   setState(() {
  //     _finished = true;
  //   });
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('View your image'),
  //       ),
  //       body: Container(
  //           alignment: Alignment.center,
  //           child: FutureBuilder<Uint8List>(
  //             future: picture.toPNG(),
  //             builder:
  //                 (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
  //               switch (snapshot.connectionState) {
  //                 case ConnectionState.done:
  //                   if (snapshot.hasError) {
  //                     return Text('Error: ${snapshot.error}');
  //                   } else {
  //                     return Image.memory(snapshot.data!);
  //                   }
  //                 default:
  //                   return const FractionallySizedBox(
  //                     widthFactor: 0.1,
  //                     alignment: Alignment.center,
  //                     child: AspectRatio(
  //                         aspectRatio: 1.0, child: CircularProgressIndicator()),
  //                   );
  //               }
  //             },
  //           )),
  //     );
  //   }));
  // }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  const DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Flexible(child: StatefulBuilder(
        //     builder: (BuildContext context, StateSetter setState) {
        //   return Container(
        //       child: Slider(
        //     value: _controller.thickness,
        //     onChanged: (double value) => setState(() {
        //       _controller.thickness = value;
        //     }),
        //     min: 1.0,
        //     max: 20.0,
        //     activeColor: Colors.white,
        //   ));
        // })),
        // StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        //   return RotatedBox(
        //       quarterTurns: _controller.eraseMode ? 2 : 0,
        //       child: IconButton(
        //           icon: const Icon(Icons.create),
        //           tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
        //               ' eraser',
        //           onPressed: () {
        //             setState(() {
        //               _controller.eraseMode = !_controller.eraseMode;
        //             });
        //           }));
        // }),
        ColorPickerButton(_controller),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;

  const ColorPickerButton(this._controller, {super.key});

  @override
  ColorPickerButtonState createState() => ColorPickerButtonState();
}

class ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_iconData, color: _color),
      tooltip: 'Change draw color',
      onPressed: _pickColor,
    );
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: Container(
                      alignment: Alignment.center,
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._controller.drawColor;

  IconData get _iconData => Icons.palette;

  set _color(Color color) {
    widget._controller.drawColor = color;
  }
}
