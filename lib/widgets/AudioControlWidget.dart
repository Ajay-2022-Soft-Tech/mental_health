import 'package:flutter/material.dart';

class AudioControlWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.replay_10)),
        IconButton(onPressed: () {}, icon: Icon(Icons.pause_circle_filled, size: 40)),
        IconButton(onPressed: () {}, icon: Icon(Icons.forward_10)),
      ],
    );
  }
}
