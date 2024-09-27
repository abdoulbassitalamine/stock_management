import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/provider/cart_provider.dart';
import 'package:stock_multi_vendors/views/buyers/inner_screen/checkout_screen.dart';
import 'package:stock_multi_vendors/views/buyers/main_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      bottomSheet:_cartProvider.totalPrice == 0.00? null: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                return CheckoutScreen();
              })
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color:_cartProvider.totalPrice==0.00? Colors.grey: primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              '\$' + _cartProvider.totalPrice.toStringAsFixed(2) + 'CHECKOUT',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Cart Screen',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 4),
        ),
        actions: [
          IconButton(
              onPressed: (){
                _cartProvider.removeAllItem();
              },
              icon: Icon(
                  CupertinoIcons.delete,color: Colors.white,)
          )
        ],
      ),

      body: _cartProvider.getcartIems.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: _cartProvider.getcartIems.length,
          itemBuilder: (context, index) {
            final cartData = _cartProvider.getcartIems.values.toList()[index];
            return Card(
              child: SizedBox(
                height: 190,
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(cartData.imageUrl[0]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartData.productName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5),
                          ),
                          Text(
                            '\$' + " " + cartData.price.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                                color: accentColor1),
                          ),
                          OutlinedButton(
                              onPressed: null,
                              child: Text(cartData.productSize)),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: cartData.quantity == 1
                                            ? null
                                            : () {
                                                _cartProvider.decrement(cartData);
                                              },
                                        icon: Icon(
                                          CupertinoIcons.minus,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      cartData.quantity.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                        onPressed: cartData.productQuantity ==
                                                cartData.quantity
                                            ? null
                                            : () {
                                                _cartProvider.increment(cartData);
                                              },
                                        icon: Icon(
                                          CupertinoIcons.plus,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    _cartProvider.removeItem(cartData.productId);

                                  },
                                  icon: Icon(CupertinoIcons.calendar_badge_minus)
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }):

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Your shopping is Empty",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 5
                ),
            ),
            SizedBox(
              height: 20,

            ),
            Container(
              height: 40,
                width: MediaQuery.of(context).size.width -40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context){
                        return MainScreen();

                      })
                  );
                },
                child: Center(child:
                const Text(
                    'CONTINUE SHOPPING',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),)),
              ),

            )

          ],
        ),
      ),
    );
  }
}
