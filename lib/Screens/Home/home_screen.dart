import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/Home/products.dart';

//This class wraps the App bar and Products classes into one
//making the homeScreen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List products = [];

  @override
  Widget build(BuildContext context) {
    //size shows total height and width of screen
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[const CustomAppBar(), Products()],
          ),
        ),
      ),
    );
  }
}
