import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/delivery_address_functions.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/delivery_address.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/nameFieldValidator.dart';

import '../Login/Validation/surnameFieldValidator.dart';

class AddaddressScreen extends StatefulWidget {
  const AddaddressScreen({Key? key}) : super(key: key);

  @override
  State<AddaddressScreen> createState() => _AddaddressScreen();
}

class _AddaddressScreen extends State<AddaddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController recipientnameEditingController =
      TextEditingController();
  final TextEditingController mobilenumberEditingController =
      TextEditingController();
  final TextEditingController complexnameEditingController =
      TextEditingController();
  final TextEditingController streetaddressEditingController =
      TextEditingController();
  final TextEditingController suburbnameEditingController =
      TextEditingController();
  final TextEditingController provinceEditingController =
      TextEditingController();
  final TextEditingController cityEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.blue,
              Color.fromARGB(255, 5, 9, 227),
              Color.fromARGB(255, 8, 0, 59),
            ])),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const CustomAppBar(),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Create New Address',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 79, 255),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: recipientnameEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Recipient Name Missing");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              recipientnameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Recipient Name',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.circleUser,
                                  size: 17,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: mobilenumberEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length != 10) {
                                return ("Phone number must be 10 digits");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              mobilenumberEditingController.text = value!;
                            },
                            //obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Phone number',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.phone,
                                  size: 17,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: complexnameEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Complex Name Missing");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              complexnameEditingController.text = value!;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Complex Name',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.circleUser,
                                  size: 17,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: streetaddressEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Street Address Missing");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              streetaddressEditingController.text = value!;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Street address',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.circleUser,
                                  size: 17,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: suburbnameEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Suburb Missing");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              suburbnameEditingController.text = value!;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Suburb',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.circleUser,
                                  size: 17,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: provinceEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Provice Missing");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              provinceEditingController.text = value!;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Province',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.circleUser,
                                  size: 17,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: cityEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("City Missing");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              cityEditingController.text = value!;
                            },
                            decoration: const InputDecoration(
                                labelText: 'City',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.circleUser,
                                  size: 17,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [
                                      Colors.blue,
                                      Color.fromARGB(255, 5, 9, 227),
                                      Color.fromARGB(255, 8, 0, 59),
                                    ])),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Add Address',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () async{
                            //add delivery address to the database.
                            if (_formKey.currentState!.validate()) {
                              await DeliveryAdressFunctions(
                                      fire: FirebaseFirestore.instance)
                                  .addDeliveryAdress(
                                      recipientnameEditingController.text,
                                      mobilenumberEditingController.text,
                                      complexnameEditingController.text,
                                      streetaddressEditingController.text,
                                      suburbnameEditingController.text,
                                      provinceEditingController.text,
                                      cityEditingController.text)
                                  .then((value) {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const DeliveryAdressScreen()));
                              });
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.asset(
                      "assets/Logo2.png",
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
