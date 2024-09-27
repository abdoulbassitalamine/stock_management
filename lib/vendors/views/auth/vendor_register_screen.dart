import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/constant.dart';
import '../../controllers/vendor_resgister_controller.dart';


class VendorRegisterScreen extends StatefulWidget {



  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String bussinessName;
  late String email;
  late String phoneNumber;
  late String  taxOptions;
  late String taxNumber;
  final VendorController _vendorController = VendorController();
  Uint8List? _image;
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  selectedGalleryImage()async{
   Uint8List im =  await _vendorController.pickStoreImage(ImageSource.gallery);
   setState(() {
     _image = im;
   });

  }
  selectedGalleryCamera()async{
    Uint8List im =  await _vendorController.pickStoreImage(ImageSource.camera);
    setState(() {
      _image = im;
    });

  }

  String? _taxStatus;
  List<String>  _taxOptions = ['YES', 'NO'];

  _saveVendorDetail()async{
    EasyLoading.show(status: 'PLEASE WAIT');
    if(_formKey.currentState!.validate()){
     String res =  await _vendorController
          .resgisterVendor
       (bussinessName,
         email,
         phoneNumber,
         countryValue,
         stateValue,
         cityValue,
         _taxStatus!,
         taxNumber,
         _image).whenComplete(() {
           EasyLoading.dismiss();

           setState(() {
             _formKey.currentState!.reset();
             _image = null;

           });

     });
    }else{
      print('Bad');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context,contrainsts){
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor1,
                          primaryColor,
                        ]
                      )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: _image != null?
                                Image.memory(_image!,fit: BoxFit.cover,)
                            :IconButton(
                              onPressed: (){
                                selectedGalleryImage();
                              },
                              icon: Icon(CupertinoIcons.photo),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },

            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value){
                        bussinessName = value;
                      },
                      validator: (value){
                        if(value!.isEmpty)
                          return "Please Business Name Must not be empty";
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText:'Bussiness Name',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onChanged: (value){
                        email = value;
                      },
                      validator: (value){
                        if(value!.isEmpty)
                          return "Please Email Address  Must not be empty";
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText:'Email Address',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onChanged: (value){
                        phoneNumber = value;
                      },
                      validator: (value){
                        if(value!.isEmpty)
                          return "Please Phone Number Must not be empty";
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText:'Phone Number',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectState(

                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged:(value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged:(value) {
                          setState(() {
                            cityValue = value;
                          });
                        },

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax Registered?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 100,
                              child: DropdownButtonFormField(
                                hint: Text  ('Select'),
                                  items: _taxOptions
                                      .map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                      value:value ,
                                        child: Text(value));
                                  }).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      _taxStatus = value;
                                    });
                                  }),
                            ),
                          ),

                        ],
                      ),
                    ),
                    if(_taxStatus == 'YES')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value){
                            taxNumber = value;
                          },
                          validator: (value){
                            if(value!.isEmpty)
                              return "Please Tax Number Must not be empty";
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Tax Number'
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          _saveVendorDetail();
                        },
                        child: Container(
                          height: 30,
                            width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('save',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
