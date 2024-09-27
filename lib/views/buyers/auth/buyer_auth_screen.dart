

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/views/buyers/auth/login_sreen.dart';
import 'package:stock_multi_vendors/views/buyers/main_screen.dart';

class BuyerAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
         return LoginScreen();
        }
        // Render your application if authenticated
        return MainScreen();
      },
    );
  }
}
