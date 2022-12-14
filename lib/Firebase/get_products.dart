import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the getting products
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class FireStoreDataBase {
  final FirebaseFirestore fire;

  FireStoreDataBase({required this.fire});
  Future getData() async {
    final CollectionReference collectionRef = fire.collection("Products");
    List products = [];

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        products.add(result.data());
      }
    });

    return products;
  }

//Function used to get a list of suggested products for the user
//the function gets all the products in the collection, then finds the products
//with the same category as the product, the user is viewing

  Future getSuggestedProducts(String category, String productID) async {
    List allProducts = await getData() as List;
    List suggestedProducts = [];
    for (int i = 0; i < allProducts.length; i++) {
      if (allProducts[i]["category"] == category &&
          allProducts[i]["productID"] != productID) {
        suggestedProducts.add(allProducts[i]);
      }
    }
    return suggestedProducts;
  }

//Function used to get a list of all the reviews for  products

  Future getProductReviews(String productID) async {
    final CollectionReference collectionRef =
        fire.collection("Products").doc(productID).collection("Reviews");
    List reviews = [];

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        reviews.add(result.data());
      }
    });

    return reviews;
  }
}
