import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';
import 'package:tutorial/widgets/reveal_area.dart';

class RevealScreen extends StatefulWidget {
  final Text text;
  final Image image;
  final Image overlayImage;

  RevealScreen(
      {
        @required this.text,
        this.overlayImage,
        this.image,
      });

  @override
  _RevealScreenState createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  bool _imageRevealed = false;

  void _onReveal() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        _imageRevealed = true;
      });
    });
  }

  reset() {
    setState(() {
      _imageRevealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.text,
            if (!_imageRevealed) Text('Swipe to reveal this plant.'),
            if (_imageRevealed) OutlineButton(
                  onPressed: this.reset,
                  child: Text('START AGAIN')
              ),
            Padding(
              padding: EdgeInsets.all(26),
              child: _imageRevealed == true ? this.widget.image : RevealArea(onThreshold: _onReveal, overlayImage: this.widget.overlayImage, image: this.widget.image)
            )
          ],
        ),
      ),
    );
  }
}