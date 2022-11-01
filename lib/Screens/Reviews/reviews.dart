import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';
import 'package:give_a_little_sdp/Screens/Reviews/review_card.dart';

//This class displays a horizontal list view
// it takes in two parameters, the category and productID of the product
// it then calls the reviews method to find related products based
//on the category
//when a product is clicked it will navigate to a new details screen
class Reviews extends StatefulWidget {
  String productID;
  Reviews({required this.productID, Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List reviews = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: FutureBuilder(
          future: FireStoreDataBase(fire: FirebaseFirestore.instance)
              .getProductReviews(widget.productID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              reviews = snapshot.data as List;
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ReviewCard(
                            review: reviews[index]['comment'],
                            name: reviews[index]['name'],
                            date: reviews[index]['date'],
                            uid: reviews[index]['uid']));
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
