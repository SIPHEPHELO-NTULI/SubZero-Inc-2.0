import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';
import 'package:give_a_little_sdp/Screens/Home/product_card.dart';
import 'package:give_a_little_sdp/firebase/get_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//This class is used to display the products from the database
// it uses the getProducts class and produces a builder.
// It uses a grid view to display each product
// within the grid view is a card
// this card is created using the productCard class
//In future : clicking on a product will take it to the details page
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController _searchController = TextEditingController();
  late Future resultsLoaded;
  List allProducts = [];
  List searchProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(
        _onSearchChanged); // the _onSearchChanged funtion is called very time when value search box changes.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getProductsStreamSnapshorts();
  }

  _onSearchChanged() {
    searchResults();
  }

  // sets the values in searchProducts list to the values we want from the allProducts list.
  searchResults() {
    var showProduct = [];

    if (_searchController.text != "") {
      //show searched product.
      for (var productSnapshot in allProducts) {
        var productName =
            productSnapshot["productName"].toString().toLowerCase();

        if (productName.contains(_searchController.text.toLowerCase())) {
          showProduct.add(productSnapshot);
        }
      }
    } else {
      // show all the products in the data base.
      showProduct = List.from(allProducts);
    }

    setState(() {
      searchProducts = showProduct;
    });
  }

  getProductsStreamSnapshorts() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Products");

    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allProducts.add(result.data());
        }
      });
    } catch (e) {
      debugPrint("Error - $e");
    }
    searchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 400,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Search...",
                fillColor: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
                itemCount: searchProducts.length,
                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => ProductCard(
                      productName: searchProducts[index]['productName'],
                      price: searchProducts[index]['price'],
                      description: "N/A",
                      image: searchProducts[index]['imageURL'],
                      press: () => {/*Navigate to details page here*/},
                    )),
          ),
        )
        // FutureBuilder(
        //   future: FireStoreDataBase().getData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return const Text(
        //         "Something went wrong",
        //       );
        //     }
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       allProducts = snapshot.data as List;

        //     }
        //     return const Center(child: CircularProgressIndicator());
        //   },
        // ),
      ],
    );
  }
}
