import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/delivery_address_functions.dart';

// returns a delivery address card view design
// ignore: must_be_immutable
class AddressCard extends StatefulWidget {
  String recipientname,
      mobilenumber,
      complexname,
      streetaddress,
      suburbname,
      province,
      city,
      docID;
  AddressCard(
      {required this.recipientname,
      required this.mobilenumber,
      required this.complexname,
      required this.streetaddress,
      required this.suburbname,
      required this.province,
      required this.city,
      required this.docID,
      Key? key})
      : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          child: Center(
            child: ListTile(
              title: Text(
                widget.recipientname,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.complexname,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  Text(widget.streetaddress,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  Text(widget.suburbname + ", " + widget.city + "\n",
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  Text(widget.mobilenumber,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            DeliveryAdressFunctions(
                                    fire: FirebaseFirestore.instance)
                                .deleteAddress(widget.docID)
                                .then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
