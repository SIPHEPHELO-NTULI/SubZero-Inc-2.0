import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Screens/Home/product_card.dart';
import 'package:give_a_little_sdp/firebase/get_products.dart';

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
  List products = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 400,
          child: TextField(
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
        FutureBuilder(
          future: FireStoreDataBase().getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                "Something went wrong",
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              products = snapshot.data as List;
              return SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      itemCount: products.length,
                      // ignore: prefer_const_constructors
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                            productName: products[index]['productName'],
                            price: products[index]['price'],
                            description: "N/A",
                            image: products[index]['imageURL'],
                            press: () => {/*Navigate to details page here*/},
                          )),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
