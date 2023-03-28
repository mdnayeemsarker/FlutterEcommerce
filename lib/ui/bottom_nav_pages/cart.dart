import 'dart:convert';

import 'package:e_commerce/helper/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Cartpage();
  }
}

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  var carts;

  Future<void> getCartList() async {
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/carts"),
      headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
    );

    setState(() {
      // if (carts["userId"] == 5) {

      // }
      carts = jsonDecode(response.body);
      print(carts);
    });
  }

  @override
  void initState() {
    getCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
    ));
  }
}
