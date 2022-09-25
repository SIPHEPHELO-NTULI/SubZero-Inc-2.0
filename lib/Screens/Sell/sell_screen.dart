import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/send_product.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/categoryvalidator.dart';
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
  Uint8List? imagefile;
  late String downloadURL;
  late String Price;
  late String filename;
  late File x;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  String productID = FirebaseFirestore.instance.collection("Products").doc().id;

  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.blue,
                  Color.fromRGBO(5, 9, 227, 1),
                  Color.fromARGB(255, 8, 0, 59),
                ])),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const CustomAppBar(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                addCoverPhoto(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: TextFormField(
                                    controller: productNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: ProductNameValidator.validate,
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: TextFormField(
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: TextFormField(
                                    controller: categoryController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: CategoryValidator.validate,
                                    decoration: InputDecoration(
                                      hintText: "Category",
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    maxLines: 4,
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          gradient: const LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Colors.blue,
                                                Color.fromARGB(255, 5, 9, 227),
                                                Color.fromARGB(255, 8, 0, 59),
                                              ])),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'POST',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        uploadImage();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ]))));
  }

  addCoverPhoto() {
    return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            setState(() {
              Uint8List? fileBytes = result.files.first.bytes;

              filename = result.files.first.name;
              print(filename);

              //imagefile = image.files.single.bytes!;
              imagefile = fileBytes;

              imageAvailable = true;
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Image Selected")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Image Not Selected")));
          }
        },
        /*child: imageAvailable
                                      ? Image.memory(imagefile!)
                                      : Text("upload"),*/
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Color.fromARGB(255, 5, 9, 227),
                    Color.fromARGB(255, 8, 0, 59)
                  ])),
          child: imageAvailable
              ? Image.memory(
                  imagefile!,
                  fit: BoxFit.fill,
                )
              : const Text(
                  "Select Image",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
        ));
  }

  Future uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${uid}/images")
        .child("post_$postID");
    await ref.putData(
        imagefile!,
        SettableMetadata(
          cacheControl: "public,max-age=300",
          contentType: "image/jpeg",
        ));

    downloadURL = await ref.getDownloadURL();

    //print("uploaded$downloadURL");
    SendProduct()
        .uploadImageToStorage(
            downloadURL,
            priceController.text,
            productNameController.text,
            descriptionController.text,
            categoryController.text)
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value))));
  }
}
