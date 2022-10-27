import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Firebase/check_product.dart';
import 'package:give_a_little_sdp/Firebase/send_review.dart';
import 'package:give_a_little_sdp/Firebase/wishlist_functions.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/body.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/suggested_products.dart';
import 'package:give_a_little_sdp/Screens/Reviews/review_validator.dart';
import 'package:give_a_little_sdp/Screens/Reviews/reviews.dart';

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
  List products = [];
  bool found = false;
  bool reviewed = false;

  String producttempRating = "0";
  String numberOfRaters = "0";
  late String tempNoRaters;
  late String productRating;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProductRating();
  }

  getProductRating() async {
    productRating = await RatingFunctions(fire: FirebaseFirestore.instance)
        .getAverageRating(widget.productID);
    tempNoRaters = await RatingFunctions(fire: FirebaseFirestore.instance)
        .getNumberOfRaters(widget.productID);

    setState(() {
      producttempRating = productRating;
      numberOfRaters = tempNoRaters;
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
                    numberOfRaters: numberOfRaters,
                    productRating: producttempRating),
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
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
                        String test = "cart";
                        isUserSignedIn(context, test);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
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
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                ),
                                Text(
                                  " Add to Wishlist",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ),
                      onTap: () {
                        String test = "wlists";
                        isUserSignedIn(context, test);
                      },
                    ),
                  ),
                ]),
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Product Reviews",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          check(context);
                        },
                        child: const Text("Write A Review",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 67, 222),
                            ))),
                  ],
                ),
                Reviews(
                  productID: widget.productID,
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }

  check(context) async {
    bool found = false;
    await CheckProduct(fire: FirebaseFirestore.instance)
        .check(widget.productID, uid!)
        .then((value) => found = value);
    if (found == true) {
      _displayDialog(context, widget.productID, uid!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 3, 79, 255),
          content: Text("You Have Not Purchased This Item")));
    }
  }

  isUserSignedIn(context, String test) {
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 3, 79, 255),
          content: Text("Please Sign In First")));
    } else {
      if (test == "cart") {
        String docID = FirebaseFirestore.instance.collection("Carts").doc().id;
        CartFunctions(fire: FirebaseFirestore.instance)
            .addToCart(widget.productID, uid!, docID)
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: const Color.fromARGB(255, 3, 79, 255),
                    content: Text(value))));
      } else if (test == "wlists") {
        String docID = FirebaseFirestore.instance.collection("Carts").doc().id;
        WishlistFunctions(fire: FirebaseFirestore.instance)
            .addToWishlist(widget.productID, uid!, docID)
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: const Color.fromARGB(255, 3, 79, 255),
                    content: Text(value))));
      }
    }
  }

  _displayDialog(BuildContext context, String productID, String uid) async {
    final myController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Write Your Review'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ReviewFieldValidator.validate,
                controller: myController,
                minLines: null,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter review',
                    focusColor: Color.fromARGB(255, 3, 79, 255)),
              ),
            ),
            actions: <Widget>[
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.blue,
                                Color.fromARGB(255, 5, 9, 227),
                                Color.fromARGB(255, 8, 0, 59),
                              ])),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await SendReview(fire: FirebaseFirestore.instance)
                          .uploadReview(productID, myController.text, uid)
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 79, 255),
                                  content: Text(value))));
                      setState(() {
                        reviewed = true;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          );
        });
  }
}
