import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stock_multi_vendors/constants/constant.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData ;

   EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();


  String? address;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    setState(() {
      _fullNameController.text = widget.userData['fullName'] ;
      _emailController.text = widget.userData['email'];
      _phoneController.text = widget.userData['phoneNumber'];

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          'Edit Profile',style: TextStyle(
          color: Colors.black,
          letterSpacing: 6,
          fontSize: 18,
        ),
        ),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: primaryColor,
                    ),
                    Positioned(
                      right: 0,
                        child: IconButton(
                      icon: Icon(CupertinoIcons.photo),
                      onPressed: (){

                      },
                    )
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: "Enter Full Name"
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: "Enter Email"
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        labelText: "Enter Phone"
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value){
                      setState(() {
                        address = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Enter Address"
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: ()async{
            EasyLoading.show(status: 'UPDATING');
            await _firestore
                .collection("buyers")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'fullName':_fullNameController.text,
              'email': _emailController.text,
              'phoneNumber': _phoneController.text,
              'address': address
            }).whenComplete(() => EasyLoading.dismiss());
            Navigator.pop(context);


          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width -50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),

            ),
            child: Center(
              child: Text('UPDATE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 6,
                ),


              ),
            ),

          ),
        ),
      ),
    );
  }
}
