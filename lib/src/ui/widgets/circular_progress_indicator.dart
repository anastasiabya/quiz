import 'package:flutter/material.dart';

class UICircularProgressIndicator extends StatelessWidget {
  const UICircularProgressIndicator({
    Key? key,
    this.strokeWidth = 4.0,
    this.color = Colors.grey,
    this.size = 25.0,
    this.progress,
  }) : super(key: key);

  final Color color;
  final double strokeWidth;
  final double size;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}
