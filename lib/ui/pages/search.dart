import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:e_commerce/helper/app_config.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Searchpage();
  }
}

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final searchTextController = TextEditingController();
  var products;
  // ignore: prefer_typing_uninitialized_variables
  var searchProduct;
  Future<void> getProductList() async {
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/products"),
      headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
    );

    setState(() {
      products = jsonDecode(response.body);
    });
  }

  Future<void> getSearchProduct(String searchData) async {
    // print(searchData);
    if (searchData.isEmpty) {
      searchProduct = "";
    }
    for (var i = 0; i < products.length; i++) {
      String title = products[i]["title"];
      if (title.contains(searchData)) {
        setState(() {
          searchProduct = products;
        });
      }
      // print(title);
    }
    print(searchProduct);
  }

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  // Future<void> getSearchProduct(String searchData, {String searchData}) async {

  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search preduct"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: searchTextController,
                  onChanged: (value) {
                    getSearchProduct(searchTextController.text);
                  },
                  decoration: const InputDecoration(
                    hintText: "Search here",
                    fillColor: Colors.green,
                  ),
                ),
              ),
              searchProduct == null
                  ? const Text("Product Not Found")
                  :
                  // Column(
                  //     children: [

                  //     ],
                  //   ),
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // physics: const ScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount:
                            searchProduct == null ? 0 : searchProduct.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  print("${searchProduct[index]["id"]} " +
                                      searchProduct[index]["title"]);
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      searchProduct[index]["image"],
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(searchProduct[index]["title"]),
                                    Text(searchProduct[index]["description"]),
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
    );
  }
}
