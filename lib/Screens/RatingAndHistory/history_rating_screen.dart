// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Firebase/rating_functions.dart';

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
  late double productRating ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          FutureBuilder(
            future:
                RatingFunctions.getProductsIn_History("PurchaseHistory2"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                userPurchaseHistory = snapshot.data as List;
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userPurchaseHistory.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 2,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              16,
                                      child: Center(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                userPurchaseHistory[index]
                                                    ['imageURL']),
                                          ),
                                          title: Text(
                                            userPurchaseHistory[index]
                                                ['productName'],
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                          subtitle: Text(
                                              userPurchaseHistory[index]
                                                  ['price'],
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          trailing: ElevatedButton(
                                            child: userPurchaseHistory[index]["isRated"]? const Text('Item Rated'):const Text('Rate Item '),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  userPurchaseHistory[index]["isRated"]?MaterialStateProperty.all(Color.fromARGB(255, 10, 226, 61)):MaterialStateProperty.all(const Color.fromARGB(255, 25, 9, 205)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (userPurchaseHistory[index]
                                                      ["isRated"] ==
                                                  false) {
                                                showDialog(
                                                    useSafeArea: false,
                                                    context: context,
                                                    builder:
                                                        (context) => Dialog(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20),
                                                            ),
                                                            elevation: 1,
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width / 5,
                                                              height: MediaQuery.of(context).size.height / 2,
                                                              decoration: const BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment.topRight,
                                                                    end: Alignment.bottomLeft,
                                                                    colors: [
                                                                      Colors.blue,
                                                                      Color.fromARGB(255, 5, 9, 227),
                                                                      Color.fromARGB(255, 8, 0, 59),
                                                                    ]),
                                                              ),
                                                              child: SingleChildScrollView(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(12.0),
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      Text(
                                                                        "Rate Item",
                                                                        style: Theme.of(context).textTheme.headline4?.copyWith(
                                                                            color: Colors.white,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 90,
                                                                      ),
                                                                      RatingBar.builder(
                                                                        initialRating: 0,
                                                                        minRating: 1,
                                                                        direction: Axis.horizontal,
                                                                        allowHalfRating: false,
                                                                        itemCount: 5,
                                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                        itemBuilder: (context, _) => const Icon(
                                                                          Icons.star,
                                                                          color: Colors.amber,
                                                                        ),
                                                                        onRatingUpdate: (rating) {
                                                                        
                                                                            productRating = rating;
                                                                        
                                                                        },
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 120,
                                                                      ),
                                                                      ElevatedButton(
                                                                        child: const Text('Submit Rating'),
                                                                        style: ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all(
                                                                              const Color.fromARGB(255, 25, 9, 205)),
                                                                          shape: MaterialStateProperty.all(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(30),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onPressed: () async{
                                                                          await RatingFunctions.rateProduct(userPurchaseHistory[index]["productID"], productRating,userPurchaseHistory[index]["historyID"]).then((value){ ScaffoldMessenger.of(context)
                                                                            .showSnackBar(SnackBar(content: Text(value)));
                                                                            setState(() {
                                                                              userPurchaseHistory = snapshot.data as List;
                                                                            });
                                                                        });
                                                                          Navigator.pop(context);
                                                                            setState(() {
                                                                              userPurchaseHistory = snapshot.data as List;
                                                                            });
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ));
                                              }
                                              else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Theme(
                                                        data: Theme.of(context).copyWith(dialogBackgroundColor: Color.fromARGB(255, 33, 110, 255)),
                                                        child: AlertDialog(
                                                          title: Text("You have already rated this item"),
                                                        ),
                                                      );
                                                    });
                                              }
                                            },
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    ),
                  ),
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
