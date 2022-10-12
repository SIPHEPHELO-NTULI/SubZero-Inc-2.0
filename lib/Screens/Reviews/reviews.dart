import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/Reviews/review_card.dart';

class Reviews extends StatefulWidget {
  final String? prodID;
  Reviews({Key? key, this.prodID}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final List comments = [];
  final List items = ["comments", "basd"];
  late final db;

  @override
  void initState() {
    super.initState();

    db = FirebaseFirestore.instance.collection("Products").doc(widget.prodID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reviews",
        ),
        backgroundColor: const Color.fromARGB(255, 0, 67, 222),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc['comments'].toString()),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
