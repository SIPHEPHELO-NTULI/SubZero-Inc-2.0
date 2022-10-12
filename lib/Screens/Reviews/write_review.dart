import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/send_comments.dart';

class write_review extends StatefulWidget {
  final String prodID;

  write_review({Key? key, required this.prodID}) : super(key: key);

  @override
  State<write_review> createState() => _write_reviewState();
}

class _write_reviewState extends State<write_review> {
  final myController = TextEditingController();
  //User? user = FirebaseAuth.instance.currentUser;

  final uid = FirebaseAuth.instance.currentUser?.uid;

  late var name = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Write Review",
        ),
        backgroundColor: const Color.fromARGB(255, 0, 67, 222),
        centerTitle: true,
      ),
      body: Column(children: [
        TextFormField(
          controller: myController,
          minLines: null,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter review',
          ),
        ),
        ElevatedButton(
            onPressed: () {
              //print(myController.text);

              SendComment.uploadComment(widget.prodID, myController.text).then(
                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 3, 79, 255),
                          content: value)));

              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Submitted")));
              Navigator.pop(context);
            },
            child: const Text("Submit")),
      ]),
    );
  }
}
