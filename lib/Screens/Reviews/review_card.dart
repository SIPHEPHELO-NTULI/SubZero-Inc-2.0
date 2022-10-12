import 'package:flutter/material.dart';

class Review_Square extends StatelessWidget {
  final String child;
  Review_Square({required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Container(
        height: 100,
        width: 5,
        color: Colors.grey,
        child: (Center(
          child: Text(
            child,
            style: TextStyle(fontSize: 30),
          ),
        )),
      ),
    );
  }
}
