import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String review;
  final String name;
  final String date;
  const ReviewCard(
      {Key? key, required this.review, required this.name, required this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
      ),
      child: (Center(
        child: ListTile(
          title: Text(
            name + ':\t' + date,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(review, style: const TextStyle(color: Colors.black)),
        ),
      )),
    );
  }
}
