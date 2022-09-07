import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/send_product.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/pricevalidator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/productNameValidator.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();
  bool imageAvailable = false;
  //late Uint8List imagefile;
  late String downloadURL;
  late String Price;

  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

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
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'UPLOAD YOUR PRODUCT',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: const Color.fromARGB(
                                              255, 3, 79, 255)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    addCoverPhoto(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 250,
                                      child: TextFormField(
                                        maxLines: 1,
                                        controller: productNameController,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator:
                                            ProductNameValidator.validate,
                                        decoration: InputDecoration(
                                          hintText: "Product Name",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 3, 79, 255)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 3, 79, 255))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 250,
                                      child: TextFormField(
                                        maxLines: 1,
                                        controller: priceController,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: PriceValidator.validate,
                                        decoration: InputDecoration(
                                          hintText: "Price",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 3, 79, 255)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 3, 79, 255))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 250,
                                      child: TextFormField(
                                        maxLines: 5,
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                          hintText: "Description",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 3, 79, 255)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 3, 79, 255))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
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
                                                    Color.fromARGB(
                                                        255, 8, 0, 59),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            SendProduct()
                                                .uploadImageToStorage(
                                                    priceController.text,
                                                    productNameController.text,
                                                    descriptionController.text)
                                                .then((value) =>
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content:
                                                                Text(value))));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ]))
            ]))));
  }

  addCoverPhoto() {
    return InkWell(
        onTap: () async {
          /*   final image = await FilePicker.platform.pickFiles();
          if (image != null) {
            setState(() {
              imagefile = image.files.single.bytes!;
              imageAvailable = true;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No Image Selected")));
          } */
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.photo,
                size: 65,
                color: Colors.grey,
              ),
              Text(
                'upload image',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ],
          ),
        ));
  }
}
