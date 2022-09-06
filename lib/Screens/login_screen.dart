import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/forgot_password.dart';

import 'package:give_a_little_sdp/Screens/registration_screen.dart';
import 'package:give_a_little_sdp/Screens/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatefulWidget {
  //final Function()  onClickedSignUp;
  const LoginScreen({Key? key,}) : super(key: key);
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final emailController = new TextEditingController(); 
  final passwordController = new TextEditingController();
  bool _obscureText =  true;

  final formKey = GlobalKey<FormState>();

  /*checkfields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }*/

  
 
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  
  Widget build(BuildContext context){
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children:[ 
          Container(
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Color.fromARGB(255, 5, 9, 227),
                  Color.fromARGB(255, 8, 0, 59),
              ])
           ),
           child: Form(
            key: formKey,
             child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAppBar(),
                //SizedBox(height: 30,),
                //Image.asset("images/logo.jpeg",width: 100,),
                SizedBox(height: 15,),
                Text('GiveALittle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      ),
                    ),
                 SizedBox(height: 30,),
                 Container(
                  //height: MediaQuery.of(context).size.height,
                    height: 550,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(children: [
                      SizedBox(height: 30,),
                      Text('Welcome Back',
                        style:  TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: 20,),
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          suffixIcon: Icon(FontAwesomeIcons.envelope,  //XXXXXXXXXXXXXXXXXX
                          size: 17,) 
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) => 
                        email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
                      ),
                    ),
                     Container(
                      width: 250,
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                            onTap: _toggle,
                            child: Icon(
                              _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,  //XXXXXXXXXXXXXXXXXX
                            size: 17,
                            )
                            ) 
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => 
                        value != null && value.length<6
                        ? 'Enter min. 6 characters'
                        : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 24),
                          GestureDetector(
                            child: Text('Forgot you password?',
                           style: TextStyle(
                            color: Colors.blueAccent[700]
                          ),),
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage())),
                          )
                          
                        ]), ),
                        SizedBox(height: 20,),
                        GestureDetector(
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
                              ]
                            )
                           ),
                           child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('SIGN IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            ),),
                          onTap: (){
                              signIn();
                          },
                        ),
                        SizedBox(height: 24,),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Color.fromARGB(255, 13, 31, 165)),
                            text: 'No account?  ',
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                ..onTap =() {
                                    Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => RegistrationScreen()));
                                  },
                                text: 'Sign Up',
                                style: TextStyle(
                                  decoration: TextDecoration.underline)
                              )
                            ]
                          ))
                  ]),
                 )
              ]
              ),
           ),
        )])),
    );
  }
  Future signIn() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), password: 
        passwordController.text.trim());
    }on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);
    }
    
  }
}
