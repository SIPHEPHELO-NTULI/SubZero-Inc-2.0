import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
import 'package:give_a_little_sdp/Firebase/create_user.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/userNameFieldValidator.dart';
import 'package:give_a_little_sdp/Screens/Login/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Validation/nameFieldValidator.dart';
import 'Validation/surnameFieldValidator.dart';

class RegistrationScreen extends StatefulWidget {
  //final Function() onClickedSignIn;
  const RegistrationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController surnameEditingController =
      TextEditingController();
  final TextEditingController usernameEditingController =
      TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();

    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
                      'Welcome',
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
                            controller: nameEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: NameFieldValidator.validate,
                            onSaved: (value) {
                              nameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Name',
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
                            controller: surnameEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: SurnameFieldValidator.validate,
                            onSaved: (value) {
                              surnameEditingController.text = value!;
                            },
                            //obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Surname',
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
                            controller: usernameEditingController,
                            validator: UserNameFieldValidator.validate,
                            decoration: const InputDecoration(
                                labelText: 'Username',
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
                            controller: emailEditingController,
                            onSaved: (value) {
                              emailEditingController.text = value!;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Email Address',
                                suffixIcon: Icon(
                                  FontAwesomeIcons
                                      .envelope, //XXXXXXXXXXXXXXXXXX
                                  size: 17,
                                )),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
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
                            controller: passwordEditingController,
                            obscureText: _obscureText,
                            onSaved: (value) {
                              passwordEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: InkWell(
                                    onTap: _toggle,
                                    child: Icon(
                                      _obscureText
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 17,
                                    ))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            //obscureText:true,
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? 'Enter min. 6 characters'
                                    : null,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            controller: confirmPasswordEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            validator: (value) {
                              if (confirmPasswordEditingController.text !=
                                  passwordEditingController.text) {
                                return "Password don't match";
                              }
                            },
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                suffixIcon: Icon(
                                  FontAwesomeIcons.eyeSlash,
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
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            signUp();
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            text: 'Already have an account?  ',
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                //on..onTap = widget.onClickedSignIn,
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                              text: 'Sign In',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 3, 79, 255),
                                  decoration: TextDecoration.underline))
                        ])),
                    const SizedBox(
                      height: 20,
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

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    await AuthService(auth: FirebaseAuth.instance)
        .signUp(emailEditingController.text.trim(),
            passwordEditingController.text.trim())
        .then((value) => {
              CreateUser(fire: FirebaseFirestore.instance).createUser(
                  nameEditingController.text,
                  surnameEditingController.text,
                  usernameEditingController.text,
                  emailEditingController.text,
                  FirebaseAuth.instance.currentUser!.uid),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: const Color.fromARGB(255, 3, 79, 255),
                  content: Text(value)))
            })
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
}
