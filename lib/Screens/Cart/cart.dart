import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/Cart/cart_list.dart';

//This class is the frame for the structure of the cart
//the cart consists of a single child scroll view
//with the list of items from the CartList class
class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Color.fromARGB(255, 5, 9, 227),
                Color.fromARGB(255, 8, 0, 59),
              ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Your Cart",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                CartList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
