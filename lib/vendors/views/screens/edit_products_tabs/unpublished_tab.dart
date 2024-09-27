import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_multi_vendors/constants/constant.dart';

class UnPublishedTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _vendorProductStream = FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: false)
      .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorProductStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text(
                'No Unpublished Product Yet',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),

              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final vendorProductData = snapshot.data!.docs[index];
                  return Slidable(
                    key: ValueKey(0),

                    startActionPane: ActionPane(

                      motion: ScrollMotion(),


                      children: [

                        SlidableAction(
                          flex: 2,
                          onPressed: (context) async {
                            await _firestore
                                .collection('products')
                                .doc(vendorProductData['productId'])
                                .update({
                              'approved': true,
                            });
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.approval_sharp,
                          label: 'Publish',
                        ),
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) async {
                            await _firestore
                                .collection('products')
                                .doc(vendorProductData['productId'])
                                .delete();
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.network(
                                vendorProductData['imageUrlList'][0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vendorProductData['productName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  '\$' +
                                      " " +
                                      vendorProductData['productPrice']
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: accentColor1),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
