import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';
import 'package:give_a_little_sdp/Screens/Home/product_card.dart';

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
  final TextEditingController _searchController = TextEditingController();

  List searchProducts = [];
  List products = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
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

    if (_searchController.text != "") {
      //show searched product.
      for (var productSnapshot in products) {
        var productName =
            productSnapshot["productName"].toString().toLowerCase();
        var category = productSnapshot["category"].toString().toLowerCase();
        if (productName.contains(_searchController.text.toLowerCase()) ||
            category.contains(_searchController.text.toLowerCase())) {
          showProduct.add(productSnapshot);
        }
      }
    } else {
      // show all the products in the data base.
      showProduct = List.from(products);
    }
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
                  crossAxisCount: 4,
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
        ),
      ],
    );
  }
}
