
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/vendors/views/screens/vendor_product_detail/vendor_product_detail_screen.dart';

class PublishedTab extends StatelessWidget {
  final FirebaseFirestore  _firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _vendorProductStream = FirebaseFirestore
      .instance
      .collection('products')
      .where('approved',isEqualTo: true)
      .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<QuerySnapshot>(
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
                'No published Product Yet',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),

              ),
            );
          }
          return   Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  final vendorProductData = snapshot.data!.docs[index];
                  return    Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key:  ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      // dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children:  [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          flex: 2,
                          onPressed: (context)async{
                           await _firestore.collection('products')
                                .doc(vendorProductData['productId'])
                                .update({
                              'approved': false,

                            });
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.approval_rounded,
                          label: 'Unpublish',
                        ),
                        SlidableAction(
                          flex: 2,
                          onPressed:(context)async{
                          await  _firestore.collection('products')
                                .doc(vendorProductData['productId'])
                                .delete();
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete ,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child:  InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return VendorProductDetailScreen(productData: vendorProductData,);
                            })
                        ) ;                    },
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.network(vendorProductData['imageUrlList'][0]),

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(vendorProductData['productName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,

                                  ),
                                ),
                                Text('\$'+" "+vendorProductData['productPrice'].toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: accentColor1

                                  ),
                                )
                              ],
                            ),
                          )
                        ],

                      ),
                  ),
                    ),

                    // The end action pane is the one at the right or the bottom side.


                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.


                  );




                }
            ),
          );
            
            
         

         




        },
      ),


    );
  }
}
