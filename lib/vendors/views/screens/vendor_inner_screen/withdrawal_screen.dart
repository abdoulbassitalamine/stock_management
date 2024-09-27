import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatefulWidget {


  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  late String amount;

  late String name;

  late String mobile;

  late String bankName;

  late String bankAccountName;
  late String bankAccountNumber;

 GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'withdraw',
          style: TextStyle(
            letterSpacing: 6,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Amount must not be empty" ;
                    }else{
                      return null;
                    }
                  },

                  onChanged: (value){
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Name must not be empty" ;
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    name = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Mobile must not be empty" ;
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    mobile = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Bank Name must not be empty" ;
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    bankName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank Name, etc Access Bank',
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Field must not be empty" ;
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    bankAccountName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank  Account Name, Eg BMCE',
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Field must not be empty" ;
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    bankAccountNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Number',
                  ),
                ),
                TextButton(onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    await _firestore.collection('withdrawal')
                        .doc(Uuid().v4())
                        .set({
                      'amount': amount,
                      'name': name,
                      'mobile': mobile,
                      'bankName': bankName,
                      'bankAccountName': bankAccountName,
                      'bankAccountNumber': bankAccountNumber

                        });

                  }

                },

                    child: Text('Get Cash',
                    style: TextStyle(
                      fontSize: 18
                    ),))

              ],
            ),
          ),
        ),
      ),

    );
  }
}
