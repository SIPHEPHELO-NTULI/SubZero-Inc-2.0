import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';

import '../Home/home_screen.dart';
import 'cart_total.dart';

class CartList extends StatefulWidget {
  CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List itemsInCart = [];
  late int numProducts;
  late var cartTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: CartHistoryFunctions.getProductsIn_Cart_History("Carts"),
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
                            trailing: GestureDetector(
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                CartHistoryFunctions()
                                    .deleteFromCart(itemsInCart[index]
                                            ["productID"]
                                        .toString())
                                    .then((value) => setState(() {
                                          itemsInCart.removeAt(index);
                                        }));
                              },
                            ),
                          );
                        }),
                  ),
                  Text("${numProducts} items",
                      style: const TextStyle(color: Colors.white)),
                  Text(" Cart Total : R${cartTotal}",
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
                                      text: "Checkout ",
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
                        await CartHistoryFunctions().emptyCart().then((value) =>
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(value))));

                        CartHistoryFunctions()
                            .addToPurchaseHistory(itemsInCart)
                            .then((value) => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(value))));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
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
}
