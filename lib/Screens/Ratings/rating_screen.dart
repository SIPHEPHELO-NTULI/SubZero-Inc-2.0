import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/rating_functions.dart';

//This Screen displays all the products previously purchased by the user
//it displays the in a list
// with a rating scheme next to each product
// a user can indicate how they choose to rate the product they p
class RatingScreen extends StatefulWidget {
  String orderID;
  RatingScreen({required this.orderID, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RatingScreenState();
}

@override
State<RatingScreen> createState() => _RatingScreenState();

class _RatingScreenState extends State<RatingScreen> {
  List products = [];
  late double productRating;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          FutureBuilder(
            future: RatingFunctions(fire: FirebaseFirestore.instance)
                .getProductsInOrder(widget.orderID),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                products = snapshot.data as List;
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 2,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              16,
                                      child: Center(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                products[index]['imageURL']),
                                          ),
                                          title: Text(
                                            products[index]['productName'],
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                          subtitle: Text(
                                              products[index]['price'],
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          trailing: ElevatedButton(
                                            child: products[index]["isRated"]
                                                ? const Text('Item Rated')
                                                : const Text('Rate Item '),
                                            style: ButtonStyle(
                                              backgroundColor: products[index]
                                                      ["isRated"]
                                                  ? MaterialStateProperty.all(
                                                      const Color.fromARGB(
                                                          255, 10, 226, 61))
                                                  : MaterialStateProperty.all(
                                                      const Color.fromARGB(
                                                          255, 25, 9, 205)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (products[index]["isRated"] ==
                                                  false) {
                                                showDialog(
                                                    useSafeArea: false,
                                                    context: context,
                                                    builder:
                                                        (context) => Dialog(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              elevation: 1,
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    5,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    2,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: const Color.fromARGB(
                                                                            255,
                                                                            3,
                                                                            79,
                                                                            255)),
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          offset: const Offset(0,
                                                                              -2),
                                                                          blurRadius:
                                                                              30,
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.16))
                                                                    ]),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          "Rate Item",
                                                                          style: Theme.of(context).textTheme.headline4?.copyWith(
                                                                              color: Colors.black,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              90,
                                                                        ),
                                                                        RatingBar
                                                                            .builder(
                                                                          initialRating:
                                                                              0,
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              false,
                                                                          itemCount:
                                                                              5,
                                                                          itemPadding:
                                                                              const EdgeInsets.symmetric(horizontal: 4.0),
                                                                          itemBuilder: (context, _) =>
                                                                              const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            productRating =
                                                                                rating;
                                                                          },
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              120,
                                                                        ),
                                                                        ElevatedButton(
                                                                          child:
                                                                              const Text('Submit Rating'),
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                                                                                255,
                                                                                25,
                                                                                9,
                                                                                205)),
                                                                            shape:
                                                                                MaterialStateProperty.all(
                                                                              RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(30),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await RatingFunctions(fire: FirebaseFirestore.instance)
                                                                                .rateProduct(
                                                                              products[index]["productID"],
                                                                              productRating,
                                                                              products[index]["docID"],
                                                                              widget.orderID,
                                                                            )
                                                                                .then((value) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color.fromARGB(255, 3, 79, 255), content: Text(value)));
                                                                              setState(() {
                                                                                products = snapshot.data as List;
                                                                              });
                                                                            });
                                                                            Navigator.pop(context);
                                                                            setState(() {
                                                                              products = snapshot.data as List;
                                                                            });
                                                                          },
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                dialogBackgroundColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        33,
                                                                        110,
                                                                        255)),
                                                        child:
                                                            const AlertDialog(
                                                          title: Text(
                                                              "You have already rated this item"),
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
