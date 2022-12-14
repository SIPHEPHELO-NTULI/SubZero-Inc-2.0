import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:give_a_little_sdp/Firebase/voucher_code_functions.dart';
import 'package:give_a_little_sdp/Screens/Home/home_screen.dart';
import 'package:give_a_little_sdp/Screens/Redeem/redeem_functions.dart';
import 'package:give_a_little_sdp/Screens/Redeem/voucher_code_validator.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({Key? key}) : super(key: key);

  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final formKey = GlobalKey<FormState>();
  final voucherCodeController = TextEditingController();
  bool temp = false;
  String amount = "";
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  void dispose() {
    voucherCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const CustomAppBar(),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Enter Voucher Code',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 3, 79, 255)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      controller: voucherCodeController,
                      decoration: const InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelText: 'XXXX-XXXX-XXXX',
                          alignLabelWithHint: true,
                          suffixIcon: Icon(
                            FontAwesomeIcons.gift,
                            size: 17,
                          )),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: VoucherCodeValidator.validate,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  isValid(),
                  const SizedBox(
                    height: 15,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.45,
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
                            "Redeem",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          bool valid = await VoucherCodeFunctions(
                                  fire: FirebaseFirestore.instance)
                              .checkCode(voucherCodeController.text);
                          if (valid) {
                            setState(() {
                              temp = true;
                              amount = RedeemFunctions().getAmount();
                            });
                            await VoucherCodeFunctions(
                                    fire: FirebaseFirestore.instance)
                                .sendVoucherCode(voucherCodeController.text);
                            await CreditFunctions(
                                    fire: FirebaseFirestore.instance)
                                .updateCredits(uid!, amount, "+")
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen())))
                                .then((value) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 3, 79, 255),
                                        content: Text("Balance Updated"))));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 3, 79, 255),
                                    content: Text(
                                        "Voucher Code Has Been Redeemed Already")));
                          }
                        }
                      },
                    ),
                  ),
                  Image.asset("assets/Logo2.png",
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.3),
                ]),
              ),
            )
          ]),
        )),
      ),
    );
  }

  Container isValid() {
    if (temp == true) {
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.45,
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
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "R" + amount,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: const Color.fromARGB(255, 0, 67, 222),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
