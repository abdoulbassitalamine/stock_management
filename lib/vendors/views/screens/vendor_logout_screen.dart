import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorLogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Signout'),
        onPressed: ()async{
          await _auth.signOut();

        },
      ),
    );
  }
}
