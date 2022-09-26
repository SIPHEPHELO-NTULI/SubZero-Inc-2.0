import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/body.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/suggested_products.dart';

//this class wraps the widgets making up the details page
// it consistss of a column that holds the appbar, as well as the body
//of the page and an add to cart button
//below this is the suggested product widget
// it helps to expand the layout in the future
class DetailsScreen extends StatelessWidget {
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
                    image: image,
                    productName: productName,
                    description: description,
                    price: price,
                    category: category),
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
                  category: category,
                  productID: productID,
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }

  isUserSignedIn(context) {
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Sign In First")));
    } else {
      CartFunctions().addToCart(productID).then((value) =>
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value))));
    }
  }
}
