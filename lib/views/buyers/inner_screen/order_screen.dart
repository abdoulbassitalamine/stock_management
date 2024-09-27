import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatelessWidget {
  String formatedDate(date){
    final ouPutDateFormate =  DateFormat('dd/MM/yyyy');
    final outPutDate = ouPutDateFormate.format(date);
    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('orders')
        .where('buyerId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation:0 ,
        title: Text(
          'My orders',
          style: TextStyle(

            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 5,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(
              color: primaryColor,
            ),);
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: data['accepted']==true? Icon(Icons.delivery_dining):
                        Icon(Icons.access_time),

                      ),
                      title: document['accepted']==true?
                      Text('Accepted',style: TextStyle(
                          color: Colors.green
                      ),):
                      Text('Not Accepted',style: TextStyle(
                          color: Colors.red
                      ),),
                      trailing: Text('Amount ' +data['productPrice'].toStringAsFixed(2) ,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                        ),),
                      subtitle: Text(
                        formatedDate(data['orderDate'].toDate()),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                        ),
                      ),
                    ),
                    ExpansionTile(title: Text(
                      'order Details',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15
                      ),
                    ),
                      subtitle: Text('View order Details'),
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: Image.network(data['productImage'][0])),
                          title: Text(data['productName']),
                          subtitle:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Quantity',style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                  Text(data['quantity'].toString())
                                ],
                              ),
                              data['accepted'] == true?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Schedule Delivery Date'),
                                  Text(formatedDate(data['scheduleDate'].toDate()))
                                ],)
                                  :Text(''),

                              ListTile(title:Text('Buyer Details',
                                style: TextStyle(
                                  fontSize: 18,

                                ),),
                                subtitle: Column(
                                  mainAxisAlignment:MainAxisAlignment.start ,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['fullName']),
                                    Text(data['email']),
                                    Text(data['address'])
                                  ],
                                )
                                ,)

                            ],
                          )  ,
                        )

                      ],
                    )
                  ],
                )
              ;

            }).toList(),
          );
        },
      ),

    );
  }
}
