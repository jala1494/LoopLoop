import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({
    this.child,
  });
  final String child;
  @override
  Widget build(BuildContext context) {
    return Text(
      child,
      style: TextStyle(fontSize: MediaQuery.of(context).size.height / 17),
    );
  }
}
