// ignore: unused_import
import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/custom_bottom_navbar.dart';
import 'package:bdm/views/screens/cart/cart.dart';
import 'package:bdm/views/screens/history/history.dart';
import 'package:bdm/views/screens/home/home.dart';
import 'package:bdm/views/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: library_private_types_in_public_api
final GlobalKey<_AppState> appKey = GlobalKey<_AppState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> pages = [Home(), Cart(), History(), Profile()];
  int index = 0;

  void changeIndex(int val) {
    setState(() {
      index = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHome: index == 0,
        title: [null, "my_cart".tr, "history".tr, "profile".tr][index],
        hasLeading: index == 0,
        hasActions: true,
      ),
      body: pages[index],
      bottomNavigationBar: CustomBottomNavbar(
        index: index,
        onChanged: (p0) {
          setState(() {
            index = p0;
          });
        },
      ),
    );
  }
}
