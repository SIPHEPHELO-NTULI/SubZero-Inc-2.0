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
          future: CartHistoryFunctions(fire: FirebaseFirestore.instance)
              .getProductsInCartHistory("Carts", uid!),
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
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(itemsInCart[index]['imageURL']),
                            ),
                            title: Text(
                              itemsInCart[index]['productName'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(itemsInCart[index]['price'],
                                style: const TextStyle(color: Colors.white)),
                            onTap: () {},
                            trailing: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  CartHistoryFunctions(
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
                          );
                        }),
                  ),
                  Text("$numProducts items",
                      style: const TextStyle(color: Colors.white)),
                  Text(" Cart Total : R$cartTotal",
                      style: const TextStyle(color: Colors.white)),
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
