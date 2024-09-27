
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/views/buyers/inner_screen/all_products_screen.dart';

class CategoryScreen extends StatelessWidget {

  final Stream<QuerySnapshot> _productStream =
  FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text('Categories',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 3
        ),),
      ),
      body:   StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor,)
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                final categoryData = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return AllProductsScreen(categoryData: categoryData,);
                        })  );
                  },

                  leading: CircleAvatar(child: Image.network(categoryData['image'],fit: BoxFit.cover,)),
                  title: Text(categoryData['categoryName']),
                ),
              );

              }
          );
        },
      )

    );
  }
}
