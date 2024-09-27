import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/utils/show_snackBar.dart';

class VendorProductDetailScreen extends StatefulWidget {
 final dynamic productData;

  const VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() => _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final FirebaseFirestore  _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    _productNameController.text = widget.productData['productName'];
    _brandNameController.text = widget.productData['brandName'];
    _productDescriptionController.text = widget.productData['description'];
    _quantityController.text = widget.productData['quantity'].toString();
    _productPriceController.text = widget.productData['productPrice'].toString();
    _categoryController.text = widget.productData['category'];
    super.initState();
  }
  double? productPrice;
  int? productQuantity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(widget.productData['productName'],
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 5
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _brandNameController,
                decoration: InputDecoration(
                  labelText: 'Brand Name',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (value){
                  productQuantity =int.parse(value);
                },
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (value){
                  productPrice = double.parse(value);
                },
                controller: _productPriceController,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                maxLength: 800,
                maxLines: 3,
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Product Description',


                ),
              ),

              SizedBox(height: 20,),
              TextFormField(
              enabled: false,
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',

                ),
              ),

            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: ()async{
        if(productQuantity!=null && productPrice!=null){
          await _firestore.collection('products')
              .doc(widget.productData['productId']).update({
            'productName':_productNameController.text,
            'brandName': _brandNameController.text,
            'quantity': productQuantity,
            'productPrice': productPrice,
            'description': _productDescriptionController.text,
            'category': _categoryController.text


          });

        }else{
          showSnackBarWarning(context, 'Updapte Quantity And Price');

        }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'UPDATE PRODUCT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
