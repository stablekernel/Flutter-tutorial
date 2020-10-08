import 'package:flutter/material.dart';

class RevealScreen extends StatefulWidget {
  final Text text;
  final Image image;

  RevealScreen(
      {
        @required this.text,
        this.image
      });

  @override
  _RevealScreenState createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.text,
            new SizedBox(
                height:350.0,
                child: widget.image
            ),
          ],
        ),
      ),
    );
  }
}