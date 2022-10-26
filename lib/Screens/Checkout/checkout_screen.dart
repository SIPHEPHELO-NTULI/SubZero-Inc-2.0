import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/delivery_address_functions.dart';
import 'package:give_a_little_sdp/Screens/Checkout/cart_items_list.dart';
import 'package:give_a_little_sdp/Screens/Checkout/checkout_functions.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';

class CheckoutScreen extends StatefulWidget {
  List itemsInCart;
  String total;
  CheckoutScreen({Key? key, required this.itemsInCart, required this.total})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List userdeliveryAdress = [];
  late int addressindex = 0;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
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
                    Text(
                      " Complete Your Order ",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: const Color.fromARGB(255, 3, 79, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemsInCart(
                          itemsInCart: widget.itemsInCart,
                          total: widget.total,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(" Delivery Address ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color:
                                        const Color.fromARGB(255, 45, 53, 70),
                                    fontWeight: FontWeight.bold)),
                        Text(" Choose Delivery Address ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color:
                                        const Color.fromARGB(255, 45, 53, 70),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold)),
                        FutureBuilder(
                          future: DeliveryAdressFunctions(
                                  fire: FirebaseFirestore.instance)
                              .getDeliveryAddress(uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              userdeliveryAdress = snapshot.data as List;
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: SingleChildScrollView(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                userdeliveryAdress.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                  child: RadioListTile(
                                                value: index,
                                                groupValue: addressindex,
                                                onChanged: (ind) =>
                                                    setState(() {
                                                  addressindex = index;
                                                }),
                                                title: ListTile(
                                                  hoverColor:
                                                      const Color.fromARGB(
                                                          255, 174, 174, 174),
                                                  title: Text(
                                                    userdeliveryAdress[index]
                                                        ['recipientname'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          userdeliveryAdress[
                                                                  index]
                                                              ['complexname'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0))),
                                                      Text(
                                                          userdeliveryAdress[
                                                                  index]
                                                              ['streetaddress'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0))),
                                                      Text(
                                                          userdeliveryAdress[
                                                                      index]
                                                                  ['suburb'] +
                                                              ", " +
                                                              userdeliveryAdress[
                                                                      index]
                                                                  ['city'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0))),
                                                      Text(
                                                          userdeliveryAdress[
                                                                  index]
                                                              ['mobilenumber'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0))),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ],
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
                                        text: " Place Order ",
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
                          await CheckoutFunctions()
                              .checkout(widget.itemsInCart, widget.total, uid)
                              .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 3, 79, 255),
                                      content: Text("Order Placed"))))
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen())));
                        },
                      ),
                    ),
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
