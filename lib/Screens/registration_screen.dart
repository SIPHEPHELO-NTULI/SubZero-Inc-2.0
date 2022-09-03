import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';
import 'package:give_a_little_sdp/Screens/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:give_a_little_sdp/Screens/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';








class surnameFieldValidator{
  static String? validate(String? value){
    RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Surname Cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Surname (3 Characters Min)");
        }
        return null;
      }
  }
class nameFieldValidator{
  static String? validate(String? value){
    RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name Cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Name (3 Characters Min)");
        }
        return null;
  }

}
class userNameFieldValidator{
  static String? validate(String? value){
    RegExp regex = new RegExp(r'^.{3,}$');
      if (value!.isEmpty) {
            return ("Username Cannot be Empty");
          }
      if (!regex.hasMatch(value)) {
            return ("Please Enter Valid Username (3 Characters Min)");
          }
    }

}
class EmailFieldValidator{
  static String? validate(String? value){  //static becuase we won't have to create an instance
    if (value!.isEmpty) {
          return "Please Enter Your Email";
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      
  }
}
class PasswordFieldValidator{
  static String? validate(String? value){
    RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Password Required";
        }

        if (!regex.hasMatch(value)) {
          return "Please Enter Valid Password (6 Characters Min)";
        }
        return null;

  }
}


class RegistrationScreen extends StatefulWidget {
  //final Function() onClickedSignIn;
  const RegistrationScreen({Key? key,}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameEditingController = new TextEditingController();
  final TextEditingController surnameEditingController = new TextEditingController();
  final TextEditingController usernameEditingController = new TextEditingController();
  final TextEditingController emailEditingController = new TextEditingController();
  final TextEditingController passwordEditingController = new TextEditingController();
   final  TextEditingController confirmPasswordEditingController = new TextEditingController();
 bool _obscureText =  true;

  
 
  @override
  void dispose(){
    emailEditingController.dispose();
    passwordEditingController.dispose();

    super.dispose();
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  

  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                  Color.fromARGB(255, 5, 111, 197),
                  Color.fromARGB(255, 5, 9, 227),
                  Color.fromARGB(255, 8, 0, 59),
              ] )
           ),
           child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(),
              SizedBox(height: 30,),
              
              SizedBox(height: 15,),
              Text('GiveALittle',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
               ),),
               SizedBox(height: 30,),
               Container(
                height: 550,
                width: 325,
                //height: MediaQuery.of(context).size.height,
          //width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                      SizedBox(height: 30,),
                      Text('Welcome',
                      style:  TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 17,),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: nameEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: nameFieldValidator.validate,
                          onSaved: (value){
                            nameEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            suffixIcon: Icon(FontAwesomeIcons.circleUser,  
                            size: 17,) 
                          ),
                        ),
                      ),
                       Container(
                        width: 250,
                        child: TextFormField(
                          controller: surnameEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: surnameFieldValidator.validate,
                          onSaved: (value){
                            surnameEditingController.text = value!;
                          },
                          //obscureText: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Surname',
                            suffixIcon: Icon(FontAwesomeIcons.circleUser,  
                            size: 17,) 
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: usernameEditingController,
                          validator: userNameFieldValidator.validate,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            suffixIcon: Icon(FontAwesomeIcons.circleUser,  
                            size: 17,) 
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: emailEditingController,
                          onSaved: (value){
                            emailEditingController.text = value!;
                          },
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
                          controller: passwordEditingController,
                          obscureText: _obscureText,
                          onSaved: (value){
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
                            )
                            ) 
                        ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            //obscureText:true,
                            validator: (value) => 
                            value != null && value.length<6
                            ? 'Enter min. 6 characters'
                            : null,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: confirmPasswordEditingController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          validator: (value){
                            if(confirmPasswordEditingController.text != passwordEditingController.text){
                              return "Password don't match";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: Icon(FontAwesomeIcons.eyeSlash,  
                            size: 17,) 
                          ),
                        ),
                      ),
                      
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
                              child: Text('SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),),
                              ),),
                              onTap: (){
                                signUp();
                              
                                
                                FirebaseFirestore.instance
                                .collection('Users')
                                .add({
                                  'name': nameEditingController.text,
                                  'surname': surnameEditingController.text,
                                  'username': usernameEditingController.text,
                                  'email': emailEditingController.text});
                                } 
                                
                              
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: 'Already have an account?  ',
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                  //on..onTap = widget.onClickedSignIn,
                                  ..onTap =() {
                                    Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => LoginScreen()));
                                  },
                                  text: 'Sign In',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline)
                                )
                              ]
                            ))
                    ]),
                  ),
                ),
               )
            ]
            ),
        )),
    );
  }

  


  Future signUp() async{
    final isValid =_formKey.currentState!.validate();
    if (!isValid) return;

    try{
      await FirebaseAuth
      .instance
      .createUserWithEmailAndPassword(
        email: emailEditingController.text.trim(), 
        password: passwordEditingController.text.trim(),
        );
    }on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);
    }
    
  }
}
