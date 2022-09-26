import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import '../../Firebase/get_products.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

@override
State<HistoryScreen> createState() => _HistoryScreenState();

class _HistoryScreenState extends State<HistoryScreen> {
  List searchProducts = [];
  List products = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProducts();
  }

  searchResults() {
    var showProduct = [];

    showProduct = List.from(products);

    setState(() {
      searchProducts = showProduct;
    });
  }

  getProducts() async {
    products = await FireStoreDataBase.getData() as List;
    searchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const CustomAppBar(),
          const Text(
            'Purchase History',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: searchProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * 2,
                      child: Stack(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Positioned(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  searchProducts[index]['imageURL'],
                                  fit: BoxFit.fill,
                                ),
                              )),
                              SizedBox(
                                width: MediaQuery.of(context).size.height * 0.1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    searchProducts[index]['productName'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  ),
                                  Text(
                                    "R" + searchProducts[index]['price'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const Text(
                                    "Date of Purchase : 22-09-22",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ]),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent
                                    ]))))
                      ]));
                }),
          )
        ],
      ),
    ));
  }
}
