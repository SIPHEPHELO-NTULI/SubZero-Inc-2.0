//import 'dart:html';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const CustomAppBar(),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 3, 79, 255)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email Address',
                          suffixIcon: Icon(
                            FontAwesomeIcons.envelope,
                            size: 17,
                          )),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
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
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        resetPassword();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/Logo2.png",
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.3),
                ]),
              ),
            )
          ]),
        )),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Utils.showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil(((route) => route.isFirst));
    } on FirebaseAuthException catch (e) {
      print(e);
      // Utils.showSnackBar(e.message);
      //Navigator.of(context).pop();
    }
  }
}
