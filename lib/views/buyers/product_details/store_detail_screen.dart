import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/views/buyers/product_details/product_details_screen.dart';

import '../../../constants/constant.dart';

class StoreDetailScreen extends StatelessWidget {
  final dynamic storeData;

  const StoreDetailScreen({super.key, required this.storeData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('vendorId',isEqualTo: storeData['vendorId'] )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(storeData['bussinessName']),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor,),
            );
          }

          if(snapshot.data!.docs.isEmpty){
            return Center(child: Text('No Product Uploaded',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),),);

          }

          return GridView.builder(
              itemCount: snapshot.data!.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 200/300

              ),
              itemBuilder: (context,index){
                final productData = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context){
                              return ProductDetailsScreen(productData: productData,);
                            })
                    );

                  },

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(productData['imageUrlList'][0]),
                                    fit: BoxFit.cover)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(productData['productName'],style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4
                            ),),
                          ),
                          SizedBox(height: 10,),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$'+ "  "+ productData['productPrice'].toStringAsFixed(2),style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                color: accentColor1
                            ),),
                          )
                        ],

                      ),
                    ),
                  ),
                );

              }
          );
        },
      ),
    );
  }
}
