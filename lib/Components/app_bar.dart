import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
import 'package:give_a_little_sdp/Screens/Cart/cart.dart';
import 'package:give_a_little_sdp/Screens/Home/bar_item.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';
import 'package:give_a_little_sdp/Screens/Login/login_screen.dart';
import 'package:give_a_little_sdp/Screens/Sell/history_screen.dart';
import 'package:give_a_little_sdp/Screens/Sell/sell_screen.dart';

//appbar for website
//in the form of a container at the top of the screen
//consists of an image and several links to other pages
//Uses the BarItem class to effectively add and edit the items in the app bar

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
              fit: BoxFit.fitWidth,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
        ),
        const Spacer(),
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
                  builder: (context) => Cart());
            }
          },
        ),
        BarItem(
          title: "ACCOUNT",
          click: () {},
        ),
        BarItem(
          title: "SELL",
          click: () {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SellScreen()));
            }
          },
        ),
        BarItem(
            title: "HISTORY",
            click: () {
              if (FirebaseAuth.instance.currentUser == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryScreen()));
              }
            })
      ]),
    );
  }

//function that determines if a user is logged in or not
//if the user is not logged in the bar item widget will
//return a bar item named LOGIN
// if they are logged in, the bar item return a bar item named
//LOGOUT
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
          AuthService().signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
      );
    }
  }
}
