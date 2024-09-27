
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/provider/cart_provider.dart';
import 'package:stock_multi_vendors/provider/product_provider.dart';
import 'my_app.dart';

  Future main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: '1:459342080841:android:551eb98152360c35bdc898'),
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_){
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_){
      return CartProvider();
    }),

  ],
  child: const MyApp()));
}

