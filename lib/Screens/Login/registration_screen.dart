import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Color.fromARGB(255, 5, 111, 197),
                      Color.fromARGB(255, 5, 9, 227),
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
                        height: 600,
                        width: 325,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _formKey,
                          child: Column(children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Container(
                              width: 250,
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
                            Container(
                              width: 250,
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
                            Container(
                              width: 250,
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
                            Container(
                              width: 250,
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
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                              ),
                            ),
                            Container(
                              width: 250,
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
                            Container(
                              width: 250,
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
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 250,
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
                            const SizedBox(
                              height: 15,
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
                                          decoration: TextDecoration.underline))
                                ])),
                            Image.asset(
                              "assets/Logo2.png",
                              width: 100,
                            ),
                          ]),
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    await AuthService()
        .signUp(emailEditingController.text.trim(),
            passwordEditingController.text.trim())
        .then((value) => {
              AuthService().createUser(
                  nameEditingController.text,
                  surnameEditingController.text,
                  usernameEditingController.text,
                  emailEditingController.text),
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value)))
            })
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }
}
