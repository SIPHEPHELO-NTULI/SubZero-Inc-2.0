

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Firebase/get_products.dart';

class HistoryScreen extends StatefulWidget{
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

@override
State<HistoryScreen> createState() => _HistoryScreenState();

class _HistoryScreenState extends State<HistoryScreen>{
    List searchProducts = [];
  List products = [];

  @override
  void initState() {
    super.initState();
   // _searchController.addListener(_onSearchChanged);
    // the _onSearchChanged funtion is called every time when value in search box changes.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProducts();
  }

  _onSearchChanged() {
    searchResults();
  }

  // sets the values in searchProducts list to the values we want from the products list.
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
      appBar: AppBar(
        title: Text(
          "HISTORY",
          ),
          ),
      body:  //_buildListView()
      Container(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: searchProducts.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.all(20),
                    //width: 100,
                    //height: 150,
                    height: MediaQuery.of(context).size.height *.2,
                    width: MediaQuery.of(context).size.width*2 ,
                    child: Stack(
                      children: [
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                            searchProducts[index]['imageURL'],
                            fit: BoxFit.fill,
                          ) ,)
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              //width: 100,
                            height:120,
                            //width: 50,
                            decoration: BoxDecoration(
                              
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent
                                ]
                              )
                            )
                          ))

                          
                      ]
                    )
                  );
                }) ,)
          ],
        ),
      )
        
      //_buildListView(),

    
    );
  }
  
}