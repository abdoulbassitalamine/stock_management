import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/vendors/views/screens/edit_product_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/upload_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/vendor_logout_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/vendor_order_screen.dart';

import 'earnings_screen.dart';

class MainVendorScreen extends StatefulWidget {

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  var _currentIndex = 0;

  List<Widget> _page = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [

        SalomonBottomBarItem(
          icon: Icon(CupertinoIcons.money_dollar),
          title: Text("EARNINGS"),
          selectedColor: primaryColor,
        ),

        SalomonBottomBarItem(
          icon: Icon(Icons.upload),
          title: Text("UPLOAD"),
          selectedColor: primaryColor,
        ),


        SalomonBottomBarItem(
          icon: Icon(Icons.edit),
          title: Text("EDIT"),
          selectedColor: primaryColor,
        ),


        SalomonBottomBarItem(
          icon: Icon(CupertinoIcons.shopping_cart),
          title: Text("ORDERS"),
          selectedColor: primaryColor,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.logout),
          title: Text("LOGOUT"),
          selectedColor: primaryColor,
        ),
      ],

    ),

      body: _page[_currentIndex],
    );
  }
}
