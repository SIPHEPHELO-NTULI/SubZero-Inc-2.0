import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/Cart/cart_list.dart';

//This class is the frame for the structure of the cart
//the cart consists of a single child scroll view
//with the list of items from the CartList class
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.16))
            ]),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text(
                  " Your Cart ",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: const Color.fromARGB(255, 3, 79, 255),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                ),
                const CartList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
