import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/account_details_functions.dart';

class ReviewCard extends StatefulWidget {
  final String review;
  final String name;
  final String date;
  final String uid;
  const ReviewCard(
      {Key? key,
      required this.review,
      required this.name,
      required this.date,
      required this.uid})
      : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  String image =
      "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";

  @override
  void initState() {
    super.initState();
    getImageURL();
  }

  getImageURL() async {
    await AccountDetails(
            auth: FirebaseAuth.instance, fire: FirebaseFirestore.instance)
        .getUserAccountImage(widget.uid)
        .then((value) => setState(() {
              image = value;
            }));
  }

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
          leading: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          title: Text(
            widget.name + ':\t' + widget.date,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle:
              Text(widget.review, style: const TextStyle(color: Colors.black)),
        ),
      )),
    );
  }
}
