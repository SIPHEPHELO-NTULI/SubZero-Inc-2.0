import 'package:flutter/material.dart';

//Represents the layout and function for the items in the appbar
//helps to set onPress methods and consistent style
class BarItem extends StatelessWidget {
  final String title;
  final VoidCallback click;
  const BarItem({
    Key? key,
    required this.title,
    required this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Text(
          title,
          style: const TextStyle(
              color: Color.fromARGB(255, 3, 79, 255),
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ),
    );
  }
}
