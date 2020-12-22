import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';
import 'package:tutorial/widgets/reveal_area.dart';
import 'package:tutorial/utility/colors.dart';

class RevealScreen extends StatefulWidget {
  final Text title;
  final Image image;
  final Image overlayImage;

  RevealScreen(
      {
        @required this.title,
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
      backgroundColor: AppColors.colorGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.title,
            SizedBox(height: 16),
            if (!_imageRevealed) Text('Swipe to reveal this plant.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            if (_imageRevealed) RaisedButton(
                  onPressed: this.reset,
                  color: AppColors.colorHighlightWhite,
                  padding: EdgeInsets.symmetric(vertical:12, horizontal: 16),
                  elevation: 5,
                  child: Text('START AGAIN', style: TextStyle(fontSize: 16, color: AppColors.colorGreen))
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 26, 35, 35),
              child: _imageRevealed == true ? this.widget.image : RevealArea(onThreshold: _onReveal, overlayImage: this.widget.overlayImage, image: this.widget.image)
            )
          ],
        ),
      ),
    );
  }
}