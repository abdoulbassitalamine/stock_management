


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/vendors/views/screens/vendor_inner_screen/withdrawal_screen.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('vendors');
    return FutureBuilder<DocumentSnapshot>(
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

          final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance.collection('orders')
              .where('vendorId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data['storeImage']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Hi "+ data['bussinessName'],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 6,


                    ),),
                  )
                ],
              ),
            ),

            body: StreamBuilder<QuerySnapshot>(
              stream: _ordersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                double totalOrder = 0.0;

                for(var orderItem in snapshot.data!.docs){
                  totalOrder +=  orderItem['quantity'] * orderItem['productPrice'];
                }

                return   Center(
                  child:Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width *0.5,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("TOTAL EARNINGS",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold, color: Colors.white


                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                               '\$ ' + totalOrder.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold, color: Colors.white,
                                    letterSpacing: 4


                                  ),),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width *0.5,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("TOTAL ORDERS",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold, color: Colors.white


                                  ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold, color: Colors.white,
                                      letterSpacing: 4


                                  ),),
                              ),


                            ],
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return WithdrawalScreen();
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width-40,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                  'Withdraw',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 6
                                ),
                              ),
                            ),
                          ),
                        )


                      ],
                    ),
                  ) ,
                );
              },
            ),



          );
        }

        return Center(child: CircularProgressIndicator(color: primaryColor,),);
      },
    );
  }
}
