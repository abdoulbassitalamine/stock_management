import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top:MediaQuery.of(context).padding.top, left: 25, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Howdy,What Are You\n Looking For  👀 ",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(child: SvgPicture.asset(
            "assets/icons/cart.svg",
            width: 20,
          ),

          )


        ],
      ),
    );
  }
}