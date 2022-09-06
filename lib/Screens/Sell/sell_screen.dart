import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/pricevalidator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/productNameValidator.dart';
import 'package:give_a_little_sdp/Screens/Sell/custom_text_form_field.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Colors.blue,
                        Color.fromRGBO(5, 9, 227, 1),
                        Color.fromARGB(255, 8, 0, 59),
                      ])),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomAppBar(),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 650,
                            width: 325,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  addCoverPhoto(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    hint: "Enter Product name",
                                    //validator: ProductNameValidator(),
                                    radius: 15,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    hint: "Description",
                                    maxLines: 4,
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    hint: "Price",
                                    // validator: PriceValidator(),
                                    maxLines: 1,
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: const LinearGradient(
                                                begin: Alignment.centerRight,
                                                end: Alignment.centerLeft,
                                                colors: [
                                                  Colors.blue,
                                                  Color.fromARGB(
                                                      255, 5, 9, 227),
                                                  Color.fromARGB(255, 8, 0, 59),
                                                ])),
                                        child: const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                            'POST',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        //send to firebase
                                        //send image to firebase storage
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ]))
            ]))));
  }

  addCoverPhoto() {
    return InkWell(
        onTap: () {
          // pick image
          //display image
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(
                Icons.photo,
                size: 65,
                color: Colors.grey,
              ),
              Text(
                "Add Photo",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
