import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/provider/product_provider.dart';
import 'package:stock_multi_vendors/vendors/views/screens/main_vendor_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/upload_tab_screens/attributes_tab_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/upload_tab_screens/general__tab_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/upload_tab_screens/image_tab_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/upload_tab_screens/shipping_tab_screen.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen>  {
 final GlobalKey<FormState>  _formKey =  GlobalKey<FormState>();
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0 ,
            bottom: TabBar(
              tabs: [
                Tab(child: Text("General",style: TextStyle(color: Colors.white),)),
                Tab(child: Text("Shipping",style: TextStyle(color: Colors.white)),),
                Tab(child: Text("Attributes",style: TextStyle(color: Colors.white)),),
                Tab(child: Text("Images",style: TextStyle(color: Colors.white)),)

              ],
            ),
          ),
          body: TabBarView(
            children: [
              GeneralTabScreen(),
              ShippingTabScreen(),
              AttributesTabScreen(),
              ImageTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  final productId = Uuid().v4();
                  await _firestore
                      .collection("products")
                      .doc(productId).set({
                    'productId': productId,
                    'productName':_productProvider.productData['productName'],
                    'quantity':_productProvider.productData['quantity'],
                    'productPrice':_productProvider.productData['productPrice'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'imageUrlList':_productProvider.productData['imageUrlList'],
                    'scheduleDate':_productProvider.productData['scheduleDate'],
                    'chargeShipping':_productProvider.productData['chargeShipping'],
                    'shippingCharge':_productProvider.productData['shippingCharge'],
                    'brandName':_productProvider.productData['brandName'],
                    'sizeList':_productProvider.productData['sizeList'],
                    'vendorId':FirebaseAuth.instance.currentUser!.uid,
                    'approved': false,
                      }).whenComplete((){
                        _productProvider.clearData();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return MainVendorScreen();
                            }
                            ));
                  });
                  print(_productProvider.productData['productName']);
                  print(_productProvider.productData['productPrice']);
                  print(_productProvider.productData['quantity']);
                  print(_productProvider.productData['category']);
                  print(_productProvider.productData['description']);
                  print(_productProvider.productData['scheduleDate']);
                  print(_productProvider.productData['imageUrlList']);
                }
              },
              child: Text('Save',style: TextStyle(color: Colors.white),),

            ),
          ),
        ),
      ),
    );

  }


}
