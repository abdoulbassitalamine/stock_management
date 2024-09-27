import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/constants/constant.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/category_screen.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/widgets/home_products.dart';
import 'package:stock_multi_vendors/views/buyers/nav_sreens/widgets/main_products_widget.dart';

class CategoryText extends StatefulWidget {



  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance.collection('categories').snapshots();

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading Categories");
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                  style: TextStyle(
                      fontSize: 19),
                ),

                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final categoryData = snapshot.data!.docs[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                  child: ActionChip(
                                      backgroundColor: primaryColor,
                                      onPressed: () {
                                        setState(() {
                                          _selectedCategory =
                                          categoryData['categoryName'];
                                        });
                                      },
                                      label: Text(
                                        categoryData['categoryName'],

                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  ),
                                );
                              })
                      ),
                      IconButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return CategoryScreen();
                                })
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios))


                    ],
                  ),
                ),
                if(_selectedCategory==null) MainProductsWidget(),
                if(_selectedCategory!=null)
                  HomeProductsWidget(categoryName: _selectedCategory!)
                
              ],
            ),
          );
        }
    );
  }
}

