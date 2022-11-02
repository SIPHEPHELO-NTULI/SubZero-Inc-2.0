import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//This is similar to the cart list
//with the exception that it requires parameters of a list and a string and a user cannot remove items from the cart
//The list will be all the items in the cart, this is so the user can view their final order

class ItemsInCart extends StatefulWidget {
  List itemsInCart;
  String total;
  ItemsInCart({Key? key, required this.itemsInCart, required this.total})
      : super(key: key);

  @override
  State<ItemsInCart> createState() => _ItemsInCartState();
}

class _ItemsInCartState extends State<ItemsInCart> {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" Your Products ",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: const Color.fromARGB(255, 45, 53, 70),
                  fontWeight: FontWeight.bold)),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.itemsInCart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.itemsInCart[index]['imageURL']),
                  ),
                  title: Text(
                    widget.itemsInCart[index]['productName'],
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(widget.itemsInCart[index]['price'],
                      style: const TextStyle(color: Colors.black)),
                );
              }),
          Text(" " + widget.itemsInCart.length.toString() + " items",
              style: const TextStyle(color: Colors.black)),
          Text(" Cart Total : R " + widget.total,
              style: const TextStyle(color: Colors.black)),
        ],
      )
    ]);
  }
}
