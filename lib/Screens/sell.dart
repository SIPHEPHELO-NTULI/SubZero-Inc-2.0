import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

class SellScreen extends StatefulWidget {
  SellScreen({Key? key, userId}) : super(key: key);
  @override
  _SellScreen createState() => _SellScreen();
}

class _SellScreen extends State<SellScreen> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  bool imageAvailable = false;
  late Uint8List imagefile;

  late String downloadURL;
  late String Price;
  late File _image;
  // ignore: non_constant_identifier_names
  late String ProductName;

  // ignore: non_constant_identifier_names
  CollectionReference Product =
      FirebaseFirestore.instance.collection('Products');

  Future<void> addProduct() {
    // Call the user's CollectionReference to add a new user
    return Product.doc(uid)
        .set({
          'imageURL': downloadURL,
          'price': Price, // S
          'productName': ProductName // 42
        })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$uid/images")
        .child("post_$postID");
    await ref.putData(imagefile);
    downloadURL = await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  }),
              const Text('Sell'),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue,
                    ),
                  ),
                  child: imageAvailable
                      ? Image.memory(imagefile)
                      : const SizedBox(),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: () async {
                      // i think the issue was caused because i was fetching the image
                      //as a data file
                      // flutter web does not allow to few images from file format
                      //try changing the display code from Image.Network to Image.memory
                      // think it might work

                      final image = await ImagePickerWeb.getImageAsBytes();

                      setState(() {
                        imagefile = image!;

                        imageAvailable = true;
                      });
                    },
                    child: Container(
                        height: 40,
                        width: 150,
                        color: Colors.blue,
                        child: const Center(
                          child: Text("Select Image"),
                        ))),
                const SizedBox(height: 10),
                Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlue,
                      ),
                    ),
                    //color: Colors.amber,
                    child: Center(
                      child: TextField(
                        onChanged: (text) {
                          ProductName = text;
                        },
                        decoration:
                            InputDecoration.collapsed(hintText: 'ProductName'),
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlue,
                      ),
                    ),
                    //color: Colors.amber,
                    child: Center(
                      child: TextField(
                        onChanged: (text) {
                          Price = text;
                        },
                        decoration:
                            InputDecoration.collapsed(hintText: 'Price'),
                      ),
                    )),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      //upload URL to cloud firestore
                      await uploadImage();
                      await addProduct();

                      print("It worked bruv");
                      print(downloadURL);
                      var snackBar =
                          SnackBar(content: Text('Product Uploaded'));
                      // Step 3
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                    child: const Text("Upload")),
              ]),
        ));
  }
}
