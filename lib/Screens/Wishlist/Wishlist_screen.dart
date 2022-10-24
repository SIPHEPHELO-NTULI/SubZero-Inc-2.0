import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/Cart/cart_list.dart';
import 'package:give_a_little_sdp/Screens/Wishlist/Wishlists.dart';

//This class is the frame for the structure of the cart
//the cart consists of a single child scroll view
//with the list of items from the CartList class
class Wishlist_Screen extends StatelessWidget {
  const Wishlist_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
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
                Row(children: <Widget>[
                  const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),
                  Text(
                    "Your Wishlist",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  )
                ]),
                Wishlists()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
