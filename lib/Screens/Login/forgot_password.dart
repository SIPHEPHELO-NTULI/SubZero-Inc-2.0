//import 'dart:html';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 450,
              width: 325,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 250,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
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
                SizedBox(
                  height: 20,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.blue,
                                Color.fromARGB(255, 5, 9, 227),
                                Color.fromARGB(255, 8, 0, 59),
                              ])),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      resetPassword();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/Logo2.png",
                  width: 200,
                ),
              ]),
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
