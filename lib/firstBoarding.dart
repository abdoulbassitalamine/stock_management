import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/splash/splash_screen.dart';
import 'package:stock_multi_vendors/vendors/views/screens/landing_screen.dart';
import 'package:stock_multi_vendors/views/buyers/main_screen.dart';
class FirstBoardingScreen extends StatefulWidget {
  @override
  State<FirstBoardingScreen> createState() => _FirstBoardingScreenState();
}

class _FirstBoardingScreenState extends State<FirstBoardingScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String typeUser = "";

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SplashScreen();
        }
        // Render your application if authenticated
        else{
          final docRef = _firestore.collection("usersType")
              .doc(FirebaseAuth.instance.currentUser!.uid);
          docRef.get().then(
                (DocumentSnapshot doc) {
              final data = doc.data() as Map<String, dynamic>;
              setState(() {
                typeUser = data["type"];

              });


            },
            onError: (e) => print("Error getting document: $e"),
          );
          if(typeUser == "buyer"){
            return MainScreen();
          }
          if(typeUser == "vendor"){
            return LandingScreen();

          }
          return SplashScreen();

        }

      },
    );
  }
}
