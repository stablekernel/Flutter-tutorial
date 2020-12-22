import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'package:tutorial/utility/colors.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final dynamic navigateAfterSeconds;
  final Image image;

  SplashScreen(
      {
        @required this.seconds,
        this.navigateAfterSeconds,
        this.title = const Text(''),
        this.image
      }
      );


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: widget.seconds),
            () {
          if (widget.navigateAfterSeconds is String) {
            Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
          } else if (widget.navigateAfterSeconds is Widget) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
          } else {
            throw new ArgumentError(
                'widget.navigateAfterSeconds must either be a String or Widget'
            );
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: AppColors.colorGrey,
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: new Container(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new SizedBox(
                            height:222.5,
                            child: widget.image
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                        ),
                        widget.title
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
