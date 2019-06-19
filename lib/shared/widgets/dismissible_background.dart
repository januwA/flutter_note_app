import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    Key key,
    @required this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: Icon(Icons.delete_forever, color: Colors.white),
        ),
      ),
    );
  }
}