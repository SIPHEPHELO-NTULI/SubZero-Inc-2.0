import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
const kDefaultPaddin = 20.0;

//This class is used to design the layout for the products
// that will be displayed in the gridView
// It organises the product image, product name and price in a column
//then a container is placed in the column for the image
//There is decoration around the image in the form of a boarder
// with a linear gradientthe product name and price are displayed
//Below the image

class ProductCard extends StatelessWidget {
  String image, productName, description, price;
  final VoidCallback press;

  ProductCard({
    required this.image,
    required this.productName,
    required this.description,
    required this.price,
    required this.press,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Color.fromARGB(255, 5, 9, 227),
                        Color.fromARGB(255, 8, 0, 59)
                      ])),
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              productName,
              style: const TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "R$price",
            style:
                const TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
