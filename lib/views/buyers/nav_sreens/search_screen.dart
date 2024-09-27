import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/views/buyers/product_details/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: TextFormField(
          style: TextStyle(
            color: Colors.white
          ),
          onChanged: (value){
            setState(() {
              _searchValue = value;

            });


          },
          decoration: InputDecoration(
            labelText: 'Search For Products',
            labelStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 4,
            ),
            prefixIcon: Icon(Icons.search,
            color: Colors.white,)
          ),
        ),
      ),
      body: _searchValue==''? Center(
        child: Text('Sear For Products',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 5
        ),),
      )
      :StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final searchData = snapshot.data!.docs.where((element){
            return element['productName']
                .toLowerCase()
                .contains(_searchValue.toLowerCase());

          });
          return Column(
            children: searchData.map((e){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ProductDetailsScreen(productData: e);
                  }));
                },
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(e['imageUrlList'][0]),
                      ),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e['productName'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Text('\$ ' +e['productPrice'].toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              color: accentColor1
                            ),),
                        ],
                      )

                    ],
                  ),
                ),
              );

            }).toList(),
          );
        },
      ),
    );
  }
}
