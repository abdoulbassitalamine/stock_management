import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/vendors/views/screens/edit_product_screen.dart';
import 'package:stock_multi_vendors/views/buyers/auth/login_sreen.dart';
import 'package:stock_multi_vendors/views/buyers/inner_screen/edit_profile.dart';
import 'package:stock_multi_vendors/views/buyers/inner_screen/order_screen.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('buyers');

  @override
  Widget build(BuildContext context) {
    return _auth.currentUser == null?  Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        title: Text(
          'Profile',
          style: TextStyle(
              letterSpacing: 4,
              color: Colors.white
          ),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(Icons.nightlight_round),
          )
        ],
      ),

      body: Center(
        child: Column(


          children: [
            SizedBox(height: 25,),
            Center(
              child: CircleAvatar(
                radius: 64,
                backgroundColor: primaryColor,
                child: Icon(Icons.person),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Login Account To Access Profile',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Login Account',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
                ,
              ),
            ),




          ],
        ),
      ),
    )



        :FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return
            Scaffold(
              appBar: AppBar(
                elevation: 2,
                backgroundColor: primaryColor,
                title: Text(
                  'Profile',
                  style: TextStyle(
                      letterSpacing: 4,
                      color: Colors.white
                  ),),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Icon(Icons.nightlight_round),
                  )
                ],
              ),

              body: Center(
                child: Column(


                  children: [
                    SizedBox(height: 25,),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: primaryColor,
                      backgroundImage: NetworkImage(data['profileImage']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data['fullName'],style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return EditProfileScreen(userData: data,);
                          })
                            );
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                        ,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data['email'],style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Divider(thickness: 2,color: Colors.grey,),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Setting"),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("Phone"),
                    ),
                    ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text("Cart")
                    ),
                    ListTile(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return CustomerOrderScreen();
                              }));


                        },
                        leading: Icon(CupertinoIcons.shopping_cart),
                        title: Text("Orders")
                    ),




                    ListTile(
                      onTap: ()async{
                        await _auth.signOut().whenComplete((){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return LoginScreen();
                              }));
                        });

                      },
                        leading: Icon(Icons.logout),
                        title: Text("Logout")
                    ),
                  ],
                ),
              ),
            );
        }

        return Center(child: CircularProgressIndicator());
      },
    );


      Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        title: Text(
            'Profile',
        style: TextStyle(
          letterSpacing: 4,
          color: Colors.white
        ),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(Icons.nightlight_round),
          )
        ],
      ),

      body: Center(
        child: Column(


          children: [
            SizedBox(height: 25,),
            CircleAvatar(
              radius: 64,
              backgroundColor: primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Bass pele",style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("abdoulbassir@gmail.com",style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(thickness: 2,color: Colors.grey,),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart")
            ),

            ListTile(
                leading: Icon(Icons.logout),
                title: Text("Loogout")
            ),
          ],
        ),
      ),
    )
    ;
  }
}
