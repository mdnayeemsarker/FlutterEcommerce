// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce/ui/bottom_nav_pages/favorite.dart';
import 'package:e_commerce/ui/bottom_nav_pages/profile.dart';
import 'package:e_commerce/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce/ui/bottom_nav_pages/shop.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  int pagePosition;
  MainPage({
    Key? key,
    required this.pagePosition,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentindex = 0;
  @override
  void initState() {
    _currentindex = widget.pagePosition;
    super.initState();
  }

  final pages = [
    const HomePage(),
    const ShopPage(),
    const CartPage(),
    const FavoritePage(),
    const ProfilePa()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: pages[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.redAccent,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.redAccent,
            icon: Icon(Icons.shop),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.redAccent,
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.redAccent,
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.redAccent,
            icon: Icon(CupertinoIcons.profile_circled),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {});
          _currentindex = index;
        },
      ),
    ));
  }
}
