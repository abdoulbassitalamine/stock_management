import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
