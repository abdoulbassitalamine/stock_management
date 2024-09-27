import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_multi_vendors/provider/product_provider.dart';
import 'package:intl/intl.dart';

class GeneralTabScreen extends StatefulWidget  {
  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen> with AutomaticKeepAliveClientMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String>  _categoryList = [];

    _getCatgeries(){
      return _firestore.collection('categories')
          .get()
           .then((QuerySnapshot querySnapshot){
             querySnapshot.docs.forEach((doc) {
               setState(() {
                 _categoryList.add(doc['categoryName']);
               });
             });
      });
    }
    @override
  void initState() {
    // TODO: implement initState
      _getCatgeries();
    super.initState();
  }

  String formateDate(date){

      final outPutDateFormate = DateFormat('yy//MM/yyy');
      final ouPutDate = outPutDateFormate.format(date);
      return ouPutDate;



  }

  @override
  Widget build(BuildContext context) {
      super.build(context);
      
      final ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Name';
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Name',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Price';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Price',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Quantity';
                  }else{
                    return null;
                  }

                },
                onChanged: (value){
                  _productProvider.getFormData(quantity: int .parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Quantity',
                ),
              ),
              const SizedBox(height: 20,),

              DropdownButtonFormField(

                hint: Text("Select Category"),
                  items: _categoryList.map<DropdownMenuItem<String>>((e){
                    return DropdownMenuItem(
                        child:Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (value){
                    _productProvider.getFormData(category: value);

                  }
                  ),
              const SizedBox(height: 30,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter Product Description';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  _productProvider.getFormData(description: value);

                },
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: 'Enter Product Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              Row
                (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                TextButton(
                    onPressed: (){
                      BottomPicker.date(
                          title:  "Select a date",
                          titleStyle:  TextStyle(
                              fontWeight:  FontWeight.bold,
                              fontSize:  15,
                              color:  Colors.blue
                          ),
                          onChange: (index) {
                            setState(() {
                              _productProvider.getFormData(sheduleDate:  index);

                            });

                          },
                          onSubmit: (index) {
                            setState(() {
                              _productProvider.getFormData(sheduleDate:  index);
                            });


                            },
                          bottomPickerTheme:  BottomPickerTheme.blue
                      ).show(context);
                    },
                    child: Text('Schedule')),

                Text(_productProvider.productData['scheduleDate']!=null ?
                formateDate(_productProvider.productData['scheduleDate']!) :''
                )
              ],)
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
