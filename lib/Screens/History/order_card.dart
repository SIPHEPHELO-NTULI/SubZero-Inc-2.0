import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/Ratings/rating_screen.dart';

//Used to design each order
// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  String recipientname, purchaseDate, total, complex, number, numItems, orderID;
  OrderCard(
      {required this.recipientname,
      required this.purchaseDate,
      required this.total,
      required this.complex,
      required this.number,
      required this.numItems,
      required this.orderID,
      Key? key})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 3, 79, 255),
        child: Center(
            child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.purchaseDate + "\n",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text("Rate Products")
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RatingScreen(
                                  orderID: widget.orderID,
                                )));
                  },
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer Name: " + widget.recipientname,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              Text("Delivery Address: " + widget.complex,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              Text("Mobile Number: " + widget.number,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              Text(widget.numItems + " items",
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              Text("Order Total: R" + widget.total,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            ],
          ),
        )));
  }
}
