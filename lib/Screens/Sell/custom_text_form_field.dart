import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.maxLines = 1,
      this.icon,
      required this.hint,
      this.radius = 10})
      : super(key: key);
  int maxLines;
  IconData? icon;
  String hint;
  String? Function(String?)? validator;
  double radius;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
          icon: icon == null ? null : Icon(icon),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: const Color.fromARGB(255, 3, 79, 255)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 3, 79, 255))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 3, 79, 255))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.red))),
    );
  }
}
