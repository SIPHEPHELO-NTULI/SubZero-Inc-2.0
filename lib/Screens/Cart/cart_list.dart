import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:give_a_little_sdp/Firebase/delivery_address_functions.dart';
import 'package:give_a_little_sdp/Screens/Checkout/checkout_functions.dart';
import 'package:give_a_little_sdp/Screens/Checkout/checkout_screen.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/delivery_address.dart';
import 'cart_total.dart';

//This Widget is responsible to retrieving all the items in a users cart
//It uses the getProductsInCart method and will display the items in a list view
//The user will be able to remove items from this list

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List itemsInCart = [];
  late int numProducts;
  late String cartTotal;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: CartFunctions(fire: FirebaseFirestore.instance)
              .getProductsInCart(uid!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              itemsInCart = snapshot.data as List;
              numProducts = itemsInCart.length;
              cartTotal = CartTotal().getCartTotal(itemsInCart);

              return Column(
                children: [
                  Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemsInCart.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    itemsInCart[index]['imageURL']),
                              ),
                              title: Text(
                                itemsInCart[index]['productName'],
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(itemsInCart[index]['price'],
                                  style: const TextStyle(color: Colors.black)),
                              onTap: () {},
                              trailing: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    CartFunctions(
                                            fire: FirebaseFirestore.instance)
                                        .deleteFromCart(
                                            itemsInCart[index]["productID"]
                                                .toString(),
                                            uid!)
                                        .then((value) => setState(() {
                                              itemsInCart.removeAt(index);
                                            }));
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("$numProducts items",
                      style: const TextStyle(color: Colors.black)),
                  Text(" Cart Total : R$cartTotal",
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(
                    height: 20,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.2,
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
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: " Proceed To Checkout ",
                                      style: TextStyle(color: Colors.white)),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.shopping_cart_checkout,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      onTap: () async {
                        if (itemsInCart.isEmpty) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 3, 79, 255),
                                  content: Text("No Items In Cart")));
                        } else {
                          await completeCheckout();
                        }
                      },
                    ),
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

  //This function is used when the user wants to checkout
  //It will first check if a user has enough credits to proceed
  //If not the relevant message will be displayed to the user
  //it will then check if the user has any delivery addresses added
  //if not the user will be directed to the page where they can add an address
  //lastly if the above are all true, the user will be directed to the checkout screen

  completeCheckout() async {
    String credits = await CreditFunctions(fire: FirebaseFirestore.instance)
        .getCurrentBalance(uid!);
    List deliveryAddresses = [];
    await DeliveryAdressFunctions(fire: FirebaseFirestore.instance)
        .getDeliveryAddress(uid!)
        .then((value) => deliveryAddresses = value as List);
    if (!CheckoutFunctions().enoughCredits(cartTotal, credits)) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 3, 79, 255),
          content: Text("Insufficient Credits")));
    } else if (deliveryAddresses.isEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DeliveryAddressScreen()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                    itemsInCart: itemsInCart,
                    total: cartTotal,
                  )));
    }
  }
}
