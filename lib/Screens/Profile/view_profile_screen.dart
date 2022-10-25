import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Models/user_model.dart';
import 'package:give_a_little_sdp/Screens/Profile/edit_profile_screen.dart';

import '../../Firebase/account_details_functions.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
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
    await AccountDetails(fire: FirebaseFirestore.instance)
        .getUserAccountDetails(user!.uid)
        .then((value) => setState(() {
              userModel = UserModel.fromMap(value.data());
              name = userModel.name.toString();
              surname = userModel.surname.toString();
              username = userModel.username.toString();
              email = user!.email.toString();
            }));
    await AccountDetails(fire: FirebaseFirestore.instance)
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
                              Container(
                                height: 160,
                                width: 160,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 3, 79, 255)),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageURL)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: "Name\n",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      TextSpan(
                                        text: name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 0, 67, 222),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: "Surname\n",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      TextSpan(
                                        text: surname,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 0, 67, 222),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: "Username\n",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      TextSpan(
                                        text: username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 0, 67, 222),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: "Email\n",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      TextSpan(
                                        text: email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 0, 67, 222),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
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
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        'EDIT DETAILS',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfile()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ]))));
  }
}
