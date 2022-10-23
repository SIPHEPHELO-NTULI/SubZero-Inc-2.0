import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:give_a_little_sdp/Screens/Profile/view_profile_screen.dart';
import 'package:give_a_little_sdp/Screens/RatingAndHistory/history_rating_screen.dart';
import 'package:give_a_little_sdp/Screens/Redeem/redeem_screen.dart';
import 'package:give_a_little_sdp/Screens/Sell/sell_screen.dart';

class DropDownAccount extends StatelessWidget {
  const DropDownAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Text(
              'ACCOUNT',
              style: TextStyle(
                  backgroundColor: Colors.white,
                  color: Color.fromARGB(255, 3, 79, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            customItemsHeights: [
              ...List<double>.filled(MenuItems.firstItems.length, 30),
              8,
              ...List<double>.filled(MenuItems.secondItems.length, 30),
            ],
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
            itemHeight: 20,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 10),
            dropdownDecoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, -2),
                      blurRadius: 30,
                      color: Colors.black.withOpacity(0.16))
                ]),
            dropdownElevation: 5,
            offset: const Offset(1.5, -4),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;

  const MenuItem({
    required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [profile, addressBook, sell];
  static const List<MenuItem> secondItems = [history, redeem];

  static const profile = MenuItem(text: 'Profile');
  static const sell = MenuItem(text: 'Sell');
  static const addressBook = MenuItem(text: 'Delivery Addresses');
  static const redeem = MenuItem(
    text: 'Redeem',
  );
  static const history = MenuItem(
    text: 'History',
  );

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Text(
          item.text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 3, 79, 255),
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.profile:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ViewProfile()));
        break;
      case MenuItems.sell:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SellScreen()));
        break;
      case MenuItems.addressBook:
        //Do something
        break;
      case MenuItems.redeem:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RedeemScreen()));
        break;
      case MenuItems.history:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()));
        break;
    }
  }
}
