import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/vendors/views/screens/edit_products_tabs/published_tab.dart';
import 'package:stock_multi_vendors/vendors/views/screens/edit_products_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Manage Products",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 7,

              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Published',style: TextStyle(color: Colors.white),)),
                Tab(child: Text('Unpublished',style: TextStyle(color: Colors.white)),)

              ],
            ),

          ),

          body: TabBarView(
            children: [
              PublishedTab(),
              UnPublishedTab()
            ],
          ),

        )
    );
  }
}
