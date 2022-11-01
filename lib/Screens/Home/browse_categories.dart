import 'package:flutter/material.dart';
import 'package:give_a_little_sdp/Components/app_bar.dart';
import 'package:give_a_little_sdp/Screens/Home/product_card.dart';
import 'package:give_a_little_sdp/Screens/ProductDetails/product_details.dart';

class BrowseCategories extends StatefulWidget {
  List products;
  BrowseCategories({Key? key, required this.products}) : super(key: key);

  @override
  State<BrowseCategories> createState() => _BrowseCategoriesState();
}

class _BrowseCategoriesState extends State<BrowseCategories> {
  List electronics = [];
  List clothing = [];
  List makeup = [];
  List accessories = [];
  List homedecor = [];

  @override
  void initState() {
    super.initState();
    sortProducts();
  }

  sortProducts() {
    setState(() {
      for (int i = 0; i < widget.products.length; i++) {
        if (widget.products[i]["category"] == "electronics") {
          electronics.add(widget.products[i]);
        } else if (widget.products[i]["category"] == "clothing") {
          clothing.add(widget.products[i]);
        } else if (widget.products[i]["category"] == "makeup") {
          makeup.add(widget.products[i]);
        } else if (widget.products[i]["category"] == "accessories") {
          accessories.add(widget.products[i]);
        } else if (widget.products[i]["category"] == "home decor") {
          homedecor.add(widget.products[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 3, 79, 255)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const CustomAppBar(),
              Column(
                children: [
                  CategoryList(
                      category: electronics, categoryName: "Electronics"),
                  CategoryList(category: clothing, categoryName: "Clothing"),
                  CategoryList(
                      category: accessories, categoryName: "Accessories"),
                  CategoryList(category: makeup, categoryName: "Make-Up"),
                  CategoryList(category: homedecor, categoryName: "Home Decor"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.category,
    required this.categoryName,
  }) : super(key: key);

  final List category;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: categoryName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color.fromARGB(255, 0, 67, 222),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ProductCard(
                    productName: category[index]['productName'],
                    price: category[index]['price'],
                    image: category[index]['imageURL'],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                            productName: category[index]['productName'],
                            price: category[index]['price'],
                            description:
                                category[index]['description'] ?? "N/A",
                            image: category[index]['imageURL'],
                            category: category[index]['category'],
                            productID: category[index]['productID']),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
