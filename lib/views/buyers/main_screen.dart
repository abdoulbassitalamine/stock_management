
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../constants/constant.dart';
import 'nav_sreens/account_screen.dart';
import 'nav_sreens/cart_screen.dart';
import 'nav_sreens/category_screen.dart';
import 'nav_sreens/home_screen.dart';
import 'nav_sreens/search_screen.dart';
import 'nav_sreens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;
  final List<Widget> _page =  [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    SearchScreen(),
    AccountScreen()
  ];


   @override

  Widget build(BuildContext context) {
    return  Scaffold(

      //
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor:primaryColor,
      //   key: _bottomNavigationKey,
      //   items: iconList,
      //   onTap: (index) {
      //     setState(() {
      //       _pageIndex = index;
      //     });
      //   },
      // ),


      // bottomNavigationBar:  AnimatedBottomNavigationBar(
      //   backgroundColor: Colors.yellow.shade900,
      //   icons: iconList,
      //   activeIndex: _bottomNavIndex,
      //   gapLocation: GapLocation.end,
      //   notchSmoothness: NotchSmoothness.verySmoothEdge,
      //   leftCornerRadius: 0,
      //   rightCornerRadius: 0,
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      //
      // ),
      // bottomNavigationBar:BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex:  _pageIndex,
      //   onTap: (value){
      //     setState(() {
      //       _pageIndex = value;
      //     });
      //   },
      //   unselectedItemColor: Colors.black,
      //   selectedItemColor: yellowShade,
      //
      //   items:  [
      //     const BottomNavigationBarItem(
      //         icon: Icon(CupertinoIcons.home),
      //       label: 'HOME'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //             "assets/icons/explore.svg",
      //           width: 20,
      //         ),
      //         label: 'CATEGORIES',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           "assets/icons/shop.svg",
      //           width: 20,
      //         ),
      //         label: 'Store'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           "assets/icons/cart.svg",
      //         ),
      //         label: 'CART'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           "assets/icons/search.svg",width: 20,
      //         ),
      //         label: 'SEARCH'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           "assets/icons/account.svg",
      //         ),
      //         label: 'ACCOUNT'
      //     ),
      //   ],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white70
          ,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs:const  [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon:Icons.category ,
                  text: 'Categories',
                ),
                GButton(
                  icon: LineIcons.store,
                  text: 'Store',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Cart',

                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: ' Account',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),

      body: _page.elementAt(_selectedIndex),

    );
  }
}


