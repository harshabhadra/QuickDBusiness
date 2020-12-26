import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Container(
      margin: EdgeInsets.fromLTRB(24, 8, 24, 8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(29),
          border: Border.all(color: Colors.deepPurple)),
      child: child,
    );
  }
}
