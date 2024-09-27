
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:stock_multi_vendors/views/buyers/inner_screen/edit_profile.dart';
import 'package:stock_multi_vendors/views/buyers/main_screen.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/home_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/constant.dart';
import '../../../provider/cart_provider.dart';
import '../../../vendors/views/screens/edit_product_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text('checkout',style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8
              ),),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _cartProvider.getcartIems.length,
                itemBuilder: (context, index) {
                  final cartData = _cartProvider.getcartIems.values.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
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
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
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

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            bottomSheet:data['address']==''?
            TextButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return EditProfileScreen(userData:  data,);
                  })
              ).whenComplete((){
                Navigator.pop(context);
              });

            },
                child: Text("Enter Billing Address")
            ) :Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  EasyLoading.show(status: 'Placing Order');
                  // we want to be able to place order, but now known, in future
                  _cartProvider.getcartIems.forEach((key, item) {
                    final orderId = Uuid().v4();
                    _firestore.collection('orders').doc(orderId).set({
                      'orderId': orderId,
                      'vendorId': item.vendorId,
                      'email': data['email'],
                      'phone': data['phoneNumber'],
                      'address': data['address'],
                      'buyerId': data['buyerId'],
                      'fullName': data['fullName'],
                      'buyerPhoto': data['profileImage'],
                      'productName':item.productName,
                      'productPrice': item.price,
                      'productId':item.price,
                      'productImage':item.imageUrl,
                      'quantity':item.quantity,
                      'productSize': item.productSize,
                      'scheduleDate':item.scheduleDate,
                      'orderDate':DateTime.now(),
                      'accepted':false,

                    }).whenComplete((){
                      setState(() {
                        _cartProvider.getcartIems.clear();
                      });


                      EasyLoading.dismiss();
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return MainScreen();
                      }));

                    });
                  });

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,

                  ),
                  child: Center(
                    child: Text('PLACE ORDER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6
                      ),),
                  ),
                ),
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(color: primaryColor,),
        );
      },
    );

  }
}
