import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Firebase/wishlist_functions.dart';

class Wishlists extends StatefulWidget {
  const Wishlists({Key? key}) : super(key: key);
  @override
  State<Wishlists> createState() => _WishlistsState();
}

class _WishlistsState extends State<Wishlists> {
  List itemsInList = [];
  late int numProducts;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
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
              return Column(
                children: [
                  Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemsInList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    itemsInList[index]['imageURL']),
                              ),
                              title: Text(
                                itemsInList[index]['productName'],
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(itemsInList[index]['price'],
                                  style: const TextStyle(color: Colors.black)),
                              trailing: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            ),
                                            Text("Add To Cart")
                                          ],
                                        ),
                                        onTap: () {
                                          String docID = FirebaseFirestore
                                              .instance
                                              .collection("Carts")
                                              .doc()
                                              .id;
                                          CartFunctions(
                                                  fire: FirebaseFirestore
                                                      .instance)
                                              .addToCart(
                                                  itemsInList[index][
                                                      'productID'],
                                                  uid!,
                                                  docID)
                                              .then(
                                                  (value) => ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  3,
                                                                  79,
                                                                  255),
                                                          content:
                                                              Text(value))));
                                        },
                                      ),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          WishlistFunctions(
                                                  fire: FirebaseFirestore
                                                      .instance)
                                              .removeFromWishlist(
                                                  itemsInList[index]
                                                          ["productID"]
                                                      .toString(),
                                                  uid!)
                                              .then((value) => setState(() {
                                                    itemsInList.removeAt(index);
                                                  }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
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
}
