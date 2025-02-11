import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/vendors/views/auth/vendor_auth.dart';
import 'package:stock_multi_vendors/views/buyers/auth/login_sreen.dart';


import '../../constants/constant.dart';
import '../../constants/size_config.dart';
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to NovaSell, Let’s shop!",
      "image": "assets/images/splash1.png"
    },
    {
      "text":
          "We help people get in touch with\n many stores in many countries.",
      "image": "assets/images/splash2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3,),
                    ElevatedButton(
                      child: Text('continue as  customer',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.white
                      ),),
                      onPressed: () {
                        Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) => LoginScreen()));

                      },
                      style:  ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor
                      )
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      child: Text('continue as  vendor   ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(14),
                      ),),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>VendorAuthScreen()));

                        },
                        style:  ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor
                        )
                    ),
                    Spacer(flex: 2,)

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
