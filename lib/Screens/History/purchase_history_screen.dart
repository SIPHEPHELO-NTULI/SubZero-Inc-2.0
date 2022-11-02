import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/purchase_history_functions.dart';
import 'package:give_a_little_sdp/Screens/History/order_card.dart';

import '../../Components/app_bar.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreen();
}

class _PurchaseHistoryScreen extends State<PurchaseHistoryScreen> {
  List orders = [];
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          FutureBuilder(
            future: PurchaseHistoryFunctions(fire: FirebaseFirestore.instance)
                .getOrders(uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                orders = snapshot.data as List;
                orders.sort(
                  (a, b) {
                    return b['purchaseDate'].compareTo(a['purchaseDate']);
                  },
                );
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 1.15,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " My Orders ",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: const Color.fromARGB(255, 3, 79, 255),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal),
                        ),
                        Center(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  return OrderCard(
                                      recipientname: orders[index]
                                          ['recipientname'],
                                      purchaseDate: orders[index]
                                          ['purchaseDate'],
                                      total: orders[index]['total'],
                                      complex: orders[index]['complexname'],
                                      number: orders[index]['mobileNumber'],
                                      numItems: orders[index]['numItems'],
                                      orderID: orders[index]['orderID']);
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    ));
  }
}
