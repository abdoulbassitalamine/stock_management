

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/constant.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/show_snackBar.dart';
import 'login_sreen.dart';

class BuyerRegisterScreen extends StatefulWidget {
  const BuyerRegisterScreen({super.key});

  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;
 bool _isLoading = false;
 Uint8List? _image;

  _signUpUser()async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading =true;
      });
       await _authController.SignUpUsers(email, fullName, phoneNumber, password,_image)
           .whenComplete((){
             setState(() {
               _formKey.currentState!.reset();
               _isLoading = false;
             });
       });
       if(context.mounted){
         return showSnackBarSucess(
             context, "Congratulatons Account Has Been created For You ");
       }

    }else{
      setState(() {
        _isLoading = false;
      });
     return showSnackBarWarning(context,"Please Fields must not be empty" );
    }




  }
  selectGaleryImage()async{
   Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
   setState(() {
     _image = im;
   });
  }

  selectCameraImage()async{
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;

    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key:_formKey ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Customer's Account",
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                Stack(
                  children: [
                    _image != null? CircleAvatar(
                      radius: 64,
                      backgroundColor: primaryColor,
                      backgroundImage: MemoryImage(_image!),
                    ) :
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: primaryColor,
                      backgroundImage: const NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png?w=740&t=st=1685905122~exp=1685905722~hmac=fcdd1c50be8dce3e4201a6ff29581fbb0c129c49de62d3ee9ac2b25de531596d"),
                    ),
                    Positioned(
                      right: 5,
                        top: 5,
                        child: IconButton(
                          color: Colors.white,
                      icon: const Icon(CupertinoIcons.photo),
                      onPressed: () {
                            selectGaleryImage();
                      },
                    ))
                  ]

                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Email must not be empty';
                      }else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter Email",

                    ),
                    onChanged: (value){
                      email = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Password must not be empty';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      fullName = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter Full Name",

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(

                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Number must not be empty';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      phoneNumber = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter Phone Number",

                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Password must not be empty';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      password = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Password",

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width -40,
                    height:50 ,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: _isLoading? const CircularProgressIndicator(
                        color: Colors.white,
                      ): const Text
                        ("Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          letterSpacing: 4
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have An Account?"),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context){
                                  return LoginScreen();
                                }
                            )
                              );
                        },
                        child: Text('Login')
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
