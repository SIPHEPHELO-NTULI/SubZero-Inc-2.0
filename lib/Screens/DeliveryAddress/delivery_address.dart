import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/delivery_address_functions.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/add_address_screen.dart';

import '../../Components/app_bar.dart';

class DeliveryAdressScreen extends StatefulWidget {
  const DeliveryAdressScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAdressScreen> createState() => _DeliveryAdress();
}

class _DeliveryAdress extends State<DeliveryAdressScreen> {
  List userdeliveryAdress = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          FutureBuilder(
            future: DeliveryAdressFunctions(fire: FirebaseFirestore.instance)
                .getDeliveryAddress(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                userdeliveryAdress = snapshot.data as List;
                return Container(
                    color: const Color.fromARGB(255, 3, 79, 255),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.15,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 30, 0, 16),
                                  child: Text("Delivery Addresses",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 30, 16),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green)),
                                    child: const Text("Add Address"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddaddressScreen()));
                                    },
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: userdeliveryAdress.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          elevation: 2,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            child: Center(
                                              child: ListTile(
                                                title: Text(
                                                  userdeliveryAdress[index]
                                                      ['recipientname'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0)),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        userdeliveryAdress[
                                                                index]
                                                            ['complexname'],
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                    Text(
                                                        userdeliveryAdress[
                                                                index]
                                                            ['streetaddress'],
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                    Text(
                                                        userdeliveryAdress[
                                                                    index]
                                                                ['suburb'] +
                                                            ", " +
                                                            userdeliveryAdress[
                                                                index]['city'] +
                                                            "\n",
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                    Text(
                                                        userdeliveryAdress[
                                                                index]
                                                            ['mobilenumber'],
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0))),
                                                  ],
                                                ),
                                                trailing: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            child: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ),
                                                            onTap: () {
                                                              DeliveryAdressFunctions(
                                                                      fire: FirebaseFirestore
                                                                          .instance)
                                                                  .deleteAddress(
                                                                      userdeliveryAdress[
                                                                              index]
                                                                          [
                                                                          'docID'])
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  userdeliveryAdress
                                                                      .removeAt(
                                                                          index);
                                                                });
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
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    ));
  }
}
