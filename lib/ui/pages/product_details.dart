// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/helper/app_config.dart';
import 'package:e_commerce/helper/app_sizing.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  var product;
  ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _dotsPosition = 0;
  List<String> _carousalSlider = [];
  int quantity = 0;

  Future<void> addToCart() async {
    // DateTime nowDate = DateTime.now();
    // int currYear = nowDate.year;
    // int currMonth = nowDate.month;
    // int currDay = nowDate.day;

    // String date = (currDay + currMonth + currYear) as String;

    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    // print("$quantity $date ${widget.product['id']}");

    Uri url = Uri.parse("${AppConfig.baseUrl}/carts");

    var post_body = jsonEncode({
      "userId": 5,
      "date": date,
      "products": {
        "productId": widget.product['id'],
        "quantity": quantity,
      },
    });

    final response = await http.post(url,
        headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
        body: post_body);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      // print(decode);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            "Product add to cart successful.!"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: "ok", onPressed: () {}),
      ));
    }
    print(response.statusCode);
  }

  Future<void> getSlider() async {
    _carousalSlider = [
      widget.product["image"],
      widget.product["image"],
      widget.product["image"],
      widget.product["image"],
    ];
  }

  @override
  void initState() {
    getSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite)),
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
          title: const Text("Product Details"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (quantity == 0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Minimum Quantity 1, Please set quantity and then add cart again.!"),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(label: "ok", onPressed: () {}),
              ));
            } else {
              addToCart();
            }
          },
          child: const Icon(Icons.add_shopping_cart),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                widget.product["title"],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppSizing.titleTS),
              ),
              const SizedBox(height: 5),
              Text(
                "\$${widget.product["price"]}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppSizing.priceTS),
              ),
              const SizedBox(height: 5),
              Text(
                widget.product["description"],
                style: const TextStyle(fontSize: AppSizing.descriptionTS),
              ),
              const SizedBox(height: 5),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quantity",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  QuantityInput(
                      value: quantity,
                      onChanged: (value) => setState(() =>
                          quantity = int.parse(value.replaceAll(',', '')))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
