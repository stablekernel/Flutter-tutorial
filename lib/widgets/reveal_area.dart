import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class ScratchArea extends StatelessWidget {
  final Image image;
  final overlayImage;

  final scratchKey = GlobalKey<ScratcherState>();

  final Function onThreshold;

  ScratchArea({
    this.onThreshold,
    this.overlayImage,
    this.image,
  });

  void reveal() {
    scratchKey.currentState.reveal();
  }

  @override
  Widget build(BuildContext context) {

    return Scratcher(
      key: scratchKey,
      brushSize: 40,
      threshold: 40,
      accuracy: ScratchAccuracy.medium,
      color: Colors.black,
      image: this.overlayImage,
      onThreshold: this.onThreshold != null
          ? this.onThreshold
          : () {
        reveal();
        print("Reached threshold");
      },
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(),
            IgnorePointer(child: this.image),
          ],
        ),
      ),
    );
  }
}
