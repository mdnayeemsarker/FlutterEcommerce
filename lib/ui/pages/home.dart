import 'dart:convert';

import 'package:e_commerce/helper/app_config.dart';
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
  Future<void> getProductList() async {
    final SharedPreferences prefs = await _prefs;
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/products"),
      headers: {
        "Accept": "*/*",
        'Content-Type': 'application/json'
        // "App-Language": "EN",
      },
    );
    // print(prefs.getString(AppConfig.TOKEN));

    setState(() {
      products = jsonDecode(response.body);
    });
  }

  Future<void> getCategories() async {
    final SharedPreferences prefs = await _prefs;
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/products/categories"),
      headers: {
        "Accept": "*/*",
        'Content-Type': 'application/json'
        // "App-Language": "EN",
      },
    );
    // print(prefs.getString(AppConfig.TOKEN));

    setState(() {
      categories = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getProductList();
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wideForcategory = MediaQuery.of(context).size.width / 2;
    final heightForcategory = MediaQuery.of(context).size.height / 8;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Categories",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: heightForcategory,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
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
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: products == null ? 0 : products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  var subDes = product["description"].substring(0, 59);
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListTile(
                        onTap: () {},
                        title: Text(product["title"]),
                        leading: Image.network(
                          product["image"],
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        subtitle: Text(subDes),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
