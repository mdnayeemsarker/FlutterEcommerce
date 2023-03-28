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
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  var userData;
  var name;
  var address;
  var geolocation;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> getUserData() async {
    final SharedPreferences prefs = await _prefs;
    // Uri url = Uri.parse("${AppConfig.baseUrl}/users");
    Uri url = Uri.parse("${AppConfig.baseUrl}/users/1");
    final response = await http.get(
      url,
      headers: {
        "Accept": "*/*",
        'Content-Type': 'application/json'
        // "App-Language": "EN",
      },
    );
    setState(() {
      userData = jsonDecode(response.body);
      name = userData["name"];
      address = userData["address"];
      geolocation = userData["geolocation"];
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: name['firstname']),
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: name['lastname']),
                )),
              ],
            ),
            TextFormField(
              readOnly: true,
              controller: _firstNameController =
                  TextEditingController(text: userData['email']),
            ),
            TextFormField(
              controller: _firstNameController =
                  TextEditingController(text: userData['username']),
            ),
            const SizedBox(height: 5),
            const Text("Address"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: address['city']),
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: address['street']),
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: address['number']),
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: address['zipcode']),
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: geolocation['lat']),
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: TextFormField(
                  controller: _firstNameController =
                      TextEditingController(text: geolocation['long']),
                )),
              ],
            ),
            TextFormField(
              controller: _firstNameController =
                  TextEditingController(text: userData['phone']),
            ),
          ],
        ),
      ),
    ));
  }
}
