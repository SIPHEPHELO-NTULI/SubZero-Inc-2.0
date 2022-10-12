import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/body.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/suggested_products.dart';
import 'package:give_a_little_sdp/Screens/Reviews/reviews.dart';
import 'package:give_a_little_sdp/Screens/Reviews/write_review.dart';

import '../../Firebase/rating_functions.dart';

//this class wraps the widgets making up the details page
// it consistss of a column that holds the appbar, as well as the body
//of the page and an add to cart button
//below this is the suggested product widget
// it helps to expand the layout in the future
class DetailsScreen extends StatefulWidget {
  String image, productName, description, price, category, productID;
  DetailsScreen(
      {required this.image,
      required this.productName,
      required this.description,
      required this.price,
      required this.category,
      required this.productID,
      Key? key})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String docID = FirebaseFirestore.instance.collection("Carts").doc().id;
  List products = [];
  bool found = false;

  String producttempRating = "0";
  late String productRating;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProductRating();
  }

  getProductRating() async {
    productRating = await RatingFunctions().getAverageRating(widget.productID);
    setState(() {
        producttempRating = productRating;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Body(
                    image: widget.image,
                    productName: widget.productName,
                    description: widget.description,
                    price: widget.price,
                    category: widget.category,
                    productRating: producttempRating),
                const SizedBox(
                  height: 20,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.blue,
                                Color.fromARGB(255, 5, 9, 227),
                                Color.fromARGB(255, 8, 0, 59),
                              ])),
                      child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          )),
                    ),
                    onTap: () {
                      isUserSignedIn(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Products You Might Like.. ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SuggestedProducts(
                  category: widget.category,
                  productID: widget.productID,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          check(context);
                        },
                        child: const Text("Write Reviews",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 67, 222),
                            ))),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reviews(
                                        prodID: widget.productID,
                                      )));
                        },
                        child: const Text("Reviews",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 67, 222),
                            ))),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    ));
  }

  check(context) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Products");
    List products = [];

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        products.add(result.data());
      }
    });

    for (int i = 0; i < products.length; i++) {
      if (products[i]["productID"] == widget.productID) {
        found = true;
      }
      print(products[i]);
    }

    if (found == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => write_review(
                    prodID: widget.productID,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You Haven't Bought This Item")));
    }
  }

  isUserSignedIn(context) {
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 3, 79, 255),
          content: Text("Please Sign In First")));
    } else {
      CartHistoryFunctions(fire: FirebaseFirestore.instance)
          .addToCart(widget.productID, uid!, docID)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: const Color.fromARGB(255, 3, 79, 255),
              content: Text(value))));
    }
  }
}
