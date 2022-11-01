import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/image_upload_function.dart';
import 'package:give_a_little_sdp/Firebase/send_product.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/price_validator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/product_name_validator.dart';

//this screen allows users to upload their own items to sell
//The users will upload an image, the image upload consists of a file picker, that
//allows users to select an image from their local drive
//once an image is selected it will be placed in the image box on the screen
//the user will then enter the product name, price, category, and description
//Once the details have been entered, they are sent to firestore database
class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();
  bool imageAvailable = false;
  Uint8List? imagefile;
  late String filename;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  String imageURL =
      "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";

  String category = 'other';
  var items = [
    'other',
    'electronics',
    'clothing',
    'shoes',
    'makeup',
    'accessories',
    'home decor',
  ];
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
                                      color: Color.fromARGB(255, 3, 79, 255)),
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
                                SizedBox(
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
                                SizedBox(
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
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Category:\n",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 3, 79, 255),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        DropdownButton(
                                          // Initial Value
                                          value: category,

                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color.fromARGB(
                                                  255, 3, 79, 255)),

                                          // Array list of items
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: RichText(
                                                  text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: items,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          ?.copyWith(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                3,
                                                                79,
                                                                255),
                                                          ))
                                                ],
                                              )),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              category = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 3, 79, 255),
                                          content: Text("Sending Product...."),
                                          duration: Duration(seconds: 5),
                                        ));
                                        String downloadURL = "";
                                        String productID = FirebaseFirestore
                                            .instance
                                            .collection("Products")
                                            .doc()
                                            .id;
                                        await Uploadmage(
                                                storage:
                                                    FirebaseStorage.instance)
                                            .uploadImage(
                                                imagefile!, uid, "$uid/images")
                                            .then(
                                                (value) => downloadURL = value);
                                        await SendProduct(
                                                fire:
                                                    FirebaseFirestore.instance)
                                            .uploadProduct(
                                                priceController.text,
                                                productNameController.text,
                                                descriptionController.text,
                                                category,
                                                productID,
                                                downloadURL)
                                            .then((value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen())));
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

              imagefile = fileBytes;

              imageAvailable = true;
            });

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Color.fromARGB(255, 3, 79, 255),
                content: Text("Image Selected")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Color.fromARGB(255, 3, 79, 255),
                content: Text("Image Not Selected")));
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: imageAvailable
              ? Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 3, 79, 255)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.contain, image: MemoryImage(imagefile!))))
              : Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 3, 79, 255)),
                    shape: BoxShape.rectangle,
                    image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/imageTempSell.png")),
                  ),
                ),
        ));
  }
}
