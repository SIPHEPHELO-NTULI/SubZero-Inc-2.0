import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//This is used for the core of the details screen
//It displays the details of a selected product
//The details are displayed in a singlechildscrollview
// the scroll view wraps a column containing a row
//within the row is positioned widget used to displaying the image
// next to image is a column that shows the product name, category
// and price as well as the description if necessary
class Body extends StatelessWidget {
  String image, productName, description, price, category, productRating;
  Body(
      {required this.image,
      required this.productName,
      required this.description,
      required this.price,
      required this.category,
      required this.productRating,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        Row(
          children: [
            Positioned(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                fit: BoxFit.fitWidth,
                height: size.height * 0.3,
                width: size.width * 0.3,
              ),
            )),
            SizedBox(width: size.width * 0.05),
            Column(
              children: [
                const SizedBox(height: 20.0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: productName,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: const Color.fromARGB(255, 0, 67, 222),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "Category\n",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: category,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: const Color.fromARGB(255, 0, 67, 222),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "Price\n",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: "R$price",
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: const Color.fromARGB(255, 0, 67, 222),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal),
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
                          text: "Description: \n",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text:
                            description, //put rating here (you can change the design/widget to how you want)
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: const Color.fromARGB(255, 0, 67, 222),
                                  fontStyle: FontStyle.italic,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "Rating: ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: double.parse(productRating) != 0
                            ? ""
                            : "No ratings",
                      ),
                    ],
                  ),
                ),
                RatingBarIndicator(
                  rating: double.parse(productRating),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 50.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
