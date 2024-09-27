import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:intl/intl.dart';
import 'package:stock_multi_vendors/provider/cart_provider.dart';
import 'package:stock_multi_vendors/utils/show_snackBar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailsScreen({super.key, required this.productData});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String formateDate(date) {
    final outputDateFormate = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormate.format(date);
    return outputDate;
  }

  int _imageIndex = 0;
  String? _selectdSize;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.productData['productName'],
          style: TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 4),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                        widget.productData['imageUrlList'][_imageIndex]),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['imageUrlList'].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor)),
                                  width: 60,
                                  height: 60,
                                  child: Image.network(widget
                                      .productData['imageUrlList'][index])),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$' +
                    " " +
                    widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 22,
                    color: accentColor1,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                  fontSize: 22, letterSpacing: 8, fontWeight: FontWeight.bold),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Description',
                    style: TextStyle(color: primaryColor),
                  ),
                  Text(
                    "View More",
                    style: TextStyle(color: primaryColor),
                  )
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(fontSize: 17, letterSpacing: 3),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "This product will be shipping On",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  formateDate(widget.productData['scheduleDate'].toDate()),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            ExpansionTile(
              title: Text('Available Size'),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: _selectdSize ==
                                    widget.productData['sizeList'][index]
                                ? accentColor1
                                : null,
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectdSize =
                                        widget.productData['sizeList'][index];
                                  });
                                  print(_selectdSize);
                                },
                                child: Text(
                                    widget.productData['sizeList'][index])),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider
              .getcartIems
              .containsKey(widget.productData['productId'])? null: () {
            if (_selectdSize == null) {
              return showSnackBarWarning(context, 'Please Select A Size');
            } else {
              _cartProvider.addProductToCart(
                widget.productData['productName'],
                widget.productData['productId'],
                widget.productData['imageUrlList'],
                1,
                widget.productData['quantity'],
                widget.productData['productPrice'],
                widget.productData['vendorId'],
                _selectdSize!,
                widget.productData['scheduleDate'],
              );
              showSnackBarSucess(context,
                  "You Added ${widget.productData['productName']}  To Your Cart" );
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color:_cartProvider
                    .getcartIems
                    .containsKey(widget.productData['productId'])? Colors.grey: primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider
                      .getcartIems
                      .containsKey(widget.productData['productId'])? 
                      Text("IN CART",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 5),)
                      
                 : Text(
                    "ADD TO CART",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 5),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
