import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/Wishlist/Wishlists.dart';

//This class is the frame for the structure of the cart
//the cart consists of a single child scroll view
//with the list of items from the CartList class
class Wishlist_Screen extends StatelessWidget {
  const Wishlist_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          ),
                          Text(
                            " Your Wishlist ",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color:
                                        const Color.fromARGB(255, 3, 79, 255),
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
        ],
      ),
    );
  }
}
