import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:e_commerce/helper/app_config.dart';

class ProfilePa extends StatelessWidget {
  const ProfilePa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Profilepage();
  }
}

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> getProductList() async {
    final SharedPreferences prefs = await _prefs;
    // Uri url = Uri.parse("${AppConfig.baseUrl}/users");
    Uri url = Uri.parse("${AppConfig.baseUrl}/users");
    final response = await http.get(
      url,
      headers: {
        "Accept": "*/*",
        'Content-Type': 'application/json'
        // "App-Language": "EN",
      },
    );
    var decode = jsonDecode(response.body);
    print(decode);
  }

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
    ));
  }
}
