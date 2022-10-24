import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';

import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:give_a_little_sdp/Firebase/wishlist_functions.dart';
import 'package:give_a_little_sdp/Screens/Checkout/checkout_functions.dart';

import '../Home/home_screen.dart';
import 'Wishlist_total.dart';

class Wishlists extends StatefulWidget {
  Wishlists({Key? key}) : super(key: key);
  @override
  State<Wishlists> createState() => _Wishlists_State();
}

class _Wishlists_State extends State<Wishlists> {
  List itemsInList = [];
  late int numProducts;
  late var listTotal;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String docID =
      FirebaseFirestore.instance.collection("PurchaseHistory").doc().id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: WishlistFunctions(fire: FirebaseFirestore.instance)
              .getProductsInList("Wishlists", uid!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              itemsInList = snapshot.data as List;
              numProducts = itemsInList.length;
              listTotal = ListTotal().getListTotal(itemsInList);

              return Column(
                children: [
                  Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemsInList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(itemsInList[index]['imageURL']),
                            ),
                            title: Text(
                              itemsInList[index]['productName'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(itemsInList[index]['price'],
                                style: const TextStyle(color: Colors.white)),
                            onTap: () {},
                            trailing: GestureDetector(
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                WishlistFunctions(
                                        fire: FirebaseFirestore.instance)
                                    .removeFromWishlist(
                                        itemsInList[index]["productID"]
                                            .toString(),
                                        uid!)
                                    .then((value) => setState(() {
                                          itemsInList.removeAt(index);
                                        }));
                              },
                            ),
                          );
                        }),
                  ),
                  Text("$numProducts items",
                      style: const TextStyle(color: Colors.white)),
                  Text(" Wishlist Total : R$listTotal",
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget confirmButton = ElevatedButton(
      child: const Text("CONFIRM"),
      style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 3, 79, 255)),
      onPressed: () {
        //completeCheckout();
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 3, 79, 255)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Payment"),
      content: const Text("Are You Sure You Want To Checkout?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
