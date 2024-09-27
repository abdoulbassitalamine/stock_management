import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/views/buyers/product_details/store_detail_screen.dart';

import '../../../constants/constant.dart';

class StoreScreen extends StatelessWidget {

  final Stream<QuerySnapshot> _vendorsStream = FirebaseFirestore.instance.collection('vendors').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: primaryColor,),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
            itemBuilder: (context, index){
            final storeData = snapshot.data!.docs[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return StoreDetailScreen(storeData: storeData,);
                }));
              },
              child: ListTile(
                title: Text(storeData['bussinessName'],
                style: TextStyle(color: Colors.black),) ,
                subtitle: Text(storeData['countryValue']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(storeData['storeImage']),
                ),
              ),
            );
            
            }
        );
      },
    );
  }
}
