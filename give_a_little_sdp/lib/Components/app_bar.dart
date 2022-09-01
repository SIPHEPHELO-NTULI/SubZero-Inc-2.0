import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
import 'package:give_a_little_sdp/Screens/Home/bar_item.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';

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
          border: Border.all(color: Color.fromARGB(255, 3, 79, 255)),
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
        BarItem(
          title: "LOGIN",
          click: () {},
        ),
        BarItem(
          title: "REGISTER",
          click: () {},
        ),
        BarItem(
          title: "CART",
          click: () {},
        ),
        BarItem(
          title: "ACCOUNT",
          click: () {},
        ),
        BarItem(
          title: "SELL",
          click: () {},
        ),
        BarItem(
          title: "LOGOUT",
          click: () {
            AuthService().signOut();
          },
        )
      ]),
    );
  }
}
