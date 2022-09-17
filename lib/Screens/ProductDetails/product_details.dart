import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/body.dart';

class DetailsScreen extends StatelessWidget {
  String image, productName, description, price, category;
  DetailsScreen(
      {required this.image,
      required this.productName,
      required this.description,
      required this.price,
      required this.category,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.blue,
            Color.fromARGB(255, 5, 9, 227),
            Color.fromARGB(255, 8, 0, 59),
          ])),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Body(
              image: image,
              productName: productName,
              description: description,
              price: price,
              category: category),
          SizedBox(
            height: 20,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
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
              onTap: () {},
            ),
          ),
        ],
      )),
    ));
  }
}
