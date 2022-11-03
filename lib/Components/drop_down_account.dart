import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/delivery_address.dart';
import 'package:give_a_little_sdp/Screens/History/purchase_history_screen.dart';
import 'package:give_a_little_sdp/Screens/Profile/view_profile_screen.dart';
import 'package:give_a_little_sdp/Screens/Redeem/redeem_screen.dart';
import 'package:give_a_little_sdp/Screens/Sell/sell_screen.dart';
import 'package:give_a_little_sdp/Screens/Wishlist/wishlist_screen.dart';

//This is the widget for the drop down Account menu
//It uses flutters drop down class
//it has been customised to display the profile image of the user(if chosen)
//as the leading button for the menu

// ignore: must_be_immutable
class DropDownAccount extends StatelessWidget {
  String imageURL;
  DropDownAccount({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(imageURL)),
              ),
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

//Each item in the drop down is of MenuItem type
//this allows us to easily add and remove items as we see fit
//currently it consists of the profile,addressbook,sell
//hsitory,redeem and wishlist tabs

class MenuItem {
  final String text;

  const MenuItem({
    required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [profile, addressBook, sell];
  static const List<MenuItem> secondItems = [purchasehistory, redeem, wishlist];

  static const profile = MenuItem(text: 'Profile');
  static const sell = MenuItem(text: 'Sell');
  static const addressBook = MenuItem(text: 'Delivery Addresses');
  static const redeem = MenuItem(
    text: 'Redeem',
  );
  static const purchasehistory = MenuItem(
    text: 'History',
  );
  static const wishlist = MenuItem(
    text: 'Wishlist',
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

//When an item has been selected from the drop down
//the relevant naviigation will take place

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DeliveryAddressScreen()));
        break;
      case MenuItems.redeem:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RedeemScreen()));
        break;
      case MenuItems.purchasehistory:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PurchaseHistoryScreen()));
        break;
      case MenuItems.wishlist:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()));
        break;
    }
  }
}
