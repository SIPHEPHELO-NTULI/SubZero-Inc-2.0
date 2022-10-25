import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/drop_down_account.dart';
import 'package:give_a_little_sdp/Firebase/account_details_functions.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:give_a_little_sdp/Screens/Cart/cart.dart';
import 'package:give_a_little_sdp/Screens/Home/bar_item.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';
import 'package:give_a_little_sdp/Screens/Login/login_screen.dart';

//appbar for website
//in the form of a container at the top of the screen
//consists of an image and several links to other pages
//Uses the BarItem class to effectively add and edit the items in the app bar

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  dynamic balance;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  dynamic name = "";
  dynamic imageURL =
      "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";

  Future<dynamic> getData() async {
    var temp = await CreditFunctions(fire: FirebaseFirestore.instance)
        .getCurrentBalance(uid!);
    setState(() {
      balance = temp;
    });
    var n = await AccountDetails(
            fire: FirebaseFirestore.instance, auth: FirebaseAuth.instance)
        .getUserName(uid!);
    setState(() {
      name = n;
    });
    var i = await AccountDetails(
            fire: FirebaseFirestore.instance, auth: FirebaseAuth.instance)
        .getUserAccountImage(uid!);
    setState(() {
      imageURL = i;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -2),
                blurRadius: 30,
                color: Colors.black.withOpacity(0.16))
          ]),
      child: Row(children: <Widget>[
        //used to change the mouse icon when hovering over the image in the app bar
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Image.asset(
              'assets/Logo.png',
              fit: BoxFit.contain,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        showUserName(context),
        const Spacer(),
        showAccount(),
        loggedIn(context),
        //BarItem class used to structure app bar items
        BarItem(
          title: "CART",
          click: () {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            } else {
              showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => const Cart());
            }
          },
        ),
        showBalance(context),
      ]),
    );
  }

  Container showAccount() {
    if (FirebaseAuth.instance.currentUser == null) {
      return Container();
    } else {
      return Container(
          color: Colors.transparent,
          width: 65,
          height: 65,
          child: DropDownAccount(
            imageURL: imageURL,
          ));
    }
  }

//function that determines if a user is logged in or not
  BarItem loggedIn(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return BarItem(
        title: "LOGIN",
        click: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
    } else {
      return BarItem(
        title: "LOGOUT",
        click: () {
          AuthService(auth: FirebaseAuth.instance).signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
      );
    }
  }

  BarItem showUserName(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return BarItem(
        title: "",
        click: () {},
      );
    } else {
      return BarItem(
        title: "Hi, " + name,
        click: () {},
      );
    }
  }

  BarItem showBalance(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return BarItem(
        title: "CREDITS",
        click: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
    }
    if (FirebaseAuth.instance.currentUser != null && balance == null) {
      return BarItem(
        title: "Credits : R0",
        click: () {},
      );
    } else {
      return BarItem(
        title: "Credits : R$balance",
        click: () {},
      );
    }
  }
}
