import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/views/buyers/product_details/product_details_screen.dart';

class HomeProductsWidget extends StatelessWidget {
  final String categoryName;


   HomeProductsWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore
        .instance
        .collection('products')
        .where('category',isEqualTo: categoryName)
        .where('approved',isEqualTo: true)
        .snapshots();
    return  StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(
              child: LinearProgressIndicator(
                color: primaryColor,
              ));
        }

        return Container(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
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
                          Stack(
                            children: [Container(
                              height: 160,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(productData['imageUrlList'][0]),
                                    fit: BoxFit.cover)
                              ),
                            ),]
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(productData['productName'],style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4
                              ),),
                            ),
                          ),

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
              },
              separatorBuilder:(context,_) => SizedBox(width: 15,),
              itemCount: snapshot.data!.docs.length
          ),

        );
      },
    );
  }
}
