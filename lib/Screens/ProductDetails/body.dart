import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  String image, productName, description, price, category;
  Body(
      {required this.image,
      required this.productName,
      required this.description,
      required this.price,
      required this.category,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category: " + category,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "Price\n",
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: "R$price",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  RichText(
                    //rating widget (subject to change)
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: "Rating: \n",
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text:
                              "", //put rating here (you can change the design/widget to how you want)
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                child: Image.network(
                  image,
                ),
                width: size.width * 0.4,
                height: size.height * 0.4,
              ),
            )
          ],
        ),
      ]),
    );
  }
}
