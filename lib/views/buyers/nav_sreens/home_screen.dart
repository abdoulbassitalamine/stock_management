import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/widgets/banner_widget.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/widgets/category_text.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/widgets/search_input_widget.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/widgets/welcome_text_widget.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
          top:MediaQuery.of(context).padding.top ,
          left: 10,
          right: 10,
      ),


      child:   SingleChildScrollView(
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            WelcomeTextWidget(),
            SizedBox(height: 14,),
            SearchInputWidget(),
            BannerWidget(),
            CategoryText()
          ],
        ),
      ),
    );
  }
}
