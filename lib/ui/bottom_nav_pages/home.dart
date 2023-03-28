// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/helper/app_config.dart';
import 'package:e_commerce/ui/pages/product_details.dart';
import 'package:e_commerce/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Homepage();
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var products;
  var categories;
  int _dotsPosition = 0;
  List<String> _carousalSlider = [];
  Future<void> getProductList() async {
    final SharedPreferences prefs = await _prefs;
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/products"),
      headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
    );

    setState(() {
      products = jsonDecode(response.body);
    });
  }

  Future<void> getSlider() async {
    _carousalSlider = [
      "https://www.mobiledokan.com/wp-content/uploads/2022/09/Apple-iPhone-14-Pro-Max.jpg",
      "https://cdn1.smartprix.com/rx-in8k1xfjU-w1200-h1200/n8k1xfjU.jpg",
      "https://cdn1.smartprix.com/rx-iEfM9LzwK-w1200-h1200/EfM9LzwK.jpg",
    ];
  }

  Future<void> getCategories() async {
    final SharedPreferences prefs = await _prefs;
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/products/categories"),
      headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
    );

    setState(() {
      categories = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getSlider();
    getProductList();
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wideForcategory = MediaQuery.of(context).size.width / 2;
    // ignore: unused_local_variable
    final heightForcategory = MediaQuery.of(context).size.height / 8;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  child: const Text("Searche product here"),
                  onPressed: () =>
                      Navigator.pushNamed(context, MyRoutes.searchRoute),
                  // readOnly: true,
                  // decoration: const InputDecoration(
                  //   hintText: "Search product here...",
                  //   border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black)),
                  // ),
                ),
              ),
              const SizedBox(height: 5),
              CarouselSlider(
                items: _carousalSlider.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(item), fit: BoxFit.fitHeight),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (val, reason) {
                    setState(() {
                      _dotsPosition = val;
                    });
                  },
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount:
                      _carousalSlider.isEmpty ? 1 : _carousalSlider.length,
                  position: _dotsPosition.toDouble(),
                  // ignore: prefer_const_constructors
                  decorator: DotsDecorator(
                      activeColor: Colors.green,
                      color: Colors.red,
                      activeSize: const Size(15, 15),
                      size: const Size(10, 10)),
                ),
              ),
              const ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: TextStyle(fontSize: 15)),
                  Text("View All", style: TextStyle(fontSize: 15))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories == null ? 0 : categories.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        width: wideForcategory,
                        child: Center(
                          child: Text(
                            categories[index],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Products", style: TextStyle(fontSize: 15)),
                  Text("View All", style: TextStyle(fontSize: 15))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products == null ? 0 : products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .8),
                  itemBuilder: (context, index) {
                    var product = products[index];
                    var subTitle = product["title"] == null
                        ? "Product title not found"
                        : product["title"].substring(0, 15);
                    var subDes = product["description"] == null
                        ? "Product description Not fouund"
                        : product["description"].substring(0, 40);
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(product: product))),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 2.2,
                                child: Image.network(
                                  product["image"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subTitle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("\$${product['price']}")
                                ],
                              ),
                              Text(subDes),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
