import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';
import 'package:give_a_little_sdp/Screens/Home/product_card.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/product_details.dart';

//This class displays a horizontal list view
// it takes in two parameters, the category and productID of the product
// it then calls the suggestedproducts method to find related products based
//on the category
//when a product is clicked it will navigate to a new details screen
class SuggestedProducts extends StatelessWidget {
  String category;
  String productID;
  SuggestedProducts({required this.category, required this.productID, Key? key})
      : super(key: key);
  List suggestedProducts = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: FutureBuilder(
          future: FireStoreDataBase.getSuggestedProducts(category, productID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              suggestedProducts = snapshot.data as List;

              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestedProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(
                        productName: suggestedProducts[index]['productName'],
                        price: suggestedProducts[index]['price'],
                        description: "N/A",
                        image: suggestedProducts[index]['imageURL'],
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                productName: suggestedProducts[index]
                                    ['productName'],
                                price: suggestedProducts[index]['price'],
                                description: "N/A",
                                image: suggestedProducts[index]['imageURL'],
                                category: suggestedProducts[index]['category'],
                                productID: suggestedProducts[index]
                                    ['productID']),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
