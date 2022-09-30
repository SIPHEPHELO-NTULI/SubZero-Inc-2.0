import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';

//This Screen displays all the products previously purchased by the user
//it displays the in a list
// with a rating scheme next to each product
// a user can indicate how they choose to rate the product they p
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

@override
State<HistoryScreen> createState() => _HistoryScreenState();

class _HistoryScreenState extends State<HistoryScreen> {
  List userPurchaseHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          FutureBuilder(
            future: CartHistoryFunctions.getProductsInCartHistory(
                "PurchaseHistory"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                userPurchaseHistory = snapshot.data as List;
                return Column(
                  children: [
                    Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userPurchaseHistory.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    userPurchaseHistory[index]['imageURL']),
                              ),
                              title: Text(
                                userPurchaseHistory[index]['productName'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              subtitle: Text(
                                  userPurchaseHistory[index]['price'],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              trailing: RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                },
                              ),
                              onTap: () {},
                            ));
                          }),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    ));
  }
}
