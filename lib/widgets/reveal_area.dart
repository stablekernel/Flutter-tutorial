import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class RevealArea extends StatelessWidget {
  final Image image;
  final overlayImage;

  final scratchKey = GlobalKey<ScratcherState>();

  final Function onThreshold;

  RevealArea({
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
      color: Colors.transparent,
      image: this.overlayImage,
      onThreshold: (this.onThreshold != null)
          ? () {
                this.onThreshold();
                this.reveal();
              }
          : () {
                print('reveal');
              },
      child: Container(
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
