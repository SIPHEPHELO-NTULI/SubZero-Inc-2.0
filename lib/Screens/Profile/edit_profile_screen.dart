import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/account_details_functions.dart';
import 'package:give_a_little_sdp/Firebase/image_upload_function.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/email_field_validator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/name_field_validator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/surname_field_validator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/username_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_a_little_sdp/Models/user_model.dart';
import 'package:give_a_little_sdp/Screens/Profile/view_profile_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool imageAvailable = false;
  Uint8List? imagefile;
  late String filename;
  bool detailsUpdated = false;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  String name = "",
      surname = "",
      username = "",
      email = "",
      imageURL =
          "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";
  UserModel userModel = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    await AccountDetails(
            fire: FirebaseFirestore.instance, auth: FirebaseAuth.instance)
        .getUserAccountDetails(user!.uid)
        .then((value) => setState(() {
              userModel = UserModel.fromMap(value.data());
              name = userModel.name.toString();
              surname = userModel.surname.toString();
              username = userModel.username.toString();
              email = user!.email.toString();
              nameController.text = name;
              surnameController.text = surname;
              usernameController.text = username;
              emailController.text = email;
            }));
    await AccountDetails(
            fire: FirebaseFirestore.instance, auth: FirebaseAuth.instance)
        .getUserAccountImage(user!.uid)
        .then((value) => setState(() {
              imageURL = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                          border: Border.all(
                              color: const Color.fromARGB(255, 3, 79, 255)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, -2),
                                blurRadius: 30,
                                color: Colors.black.withOpacity(0.16))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Personal Details',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 3, 79, 255)),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                addProfilePicture(),
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
                                    controller: nameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: NameFieldValidator.validate,
                                    decoration: InputDecoration(
                                      labelText: "First Name",
                                      hintText: "First Name",
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
                                    controller: surnameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: SurnameFieldValidator.validate,
                                    decoration: InputDecoration(
                                      labelText: "Last Name",
                                      hintText: "Last Name",
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
                                    controller: usernameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: UserNameFieldValidator.validate,
                                    decoration: InputDecoration(
                                      labelText: "Username",
                                      hintText: "Username",
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
                                    controller: emailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: EmailFieldValidator.validate,
                                    decoration: InputDecoration(
                                      labelText: "Email Address",
                                      hintText: "Email Address",
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
                                          'SAVE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await updateDetails();
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

  addProfilePicture() {
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
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 3, 79, 255)),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: MemoryImage(imagefile!))))
              : Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 3, 79, 255)),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageURL)),
                  ),
                ),
        ));
  }

  Future updateDetails() async {
    late String downloadURL;
    if (imageAvailable) {
      await Uploadmage(storage: FirebaseStorage.instance)
          .uploadImage(
              imagefile!, user!.uid, "${user!.uid}/images/profilePicture")
          .then((value) => downloadURL = value);
    } else {
      await AccountDetails(
              fire: FirebaseFirestore.instance, auth: FirebaseAuth.instance)
          .getUserAccountImage(FirebaseAuth.instance.currentUser!.uid)
          .then((value) => downloadURL = value);
    }
    await AccountDetails(
            fire: FirebaseFirestore.instance, auth: FirebaseAuth.instance)
        .sendUpdatedDetails(
            downloadURL,
            nameController.text,
            surnameController.text,
            usernameController.text,
            email,
            emailController.text)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(255, 3, 79, 255),
            content: Text(value))))
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ViewProfile())));
  }
}
