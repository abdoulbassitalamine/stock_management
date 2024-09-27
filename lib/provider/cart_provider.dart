import 'package:flutter/cupertino.dart';
import 'package:stock_multi_vendors/models/cart_attributes.dart';

class CartProvider with ChangeNotifier{
  Map<String,CartAttr> _cartIems  = {};

  Map<String, CartAttr> get getcartIems => _cartIems;

  double get totalPrice{

    var total = 0.0;
    _cartIems.forEach((key, value) {
      total += value.price*value.quantity;

    });
    return total;
  }

  void addProductToCart(
      String productName,
      String productId,
      List imageUrl,
      int quantity,
      int productQuantity,
      double price,
      String vendorId,
      String productSize,
      scheduleDate
      ){
    if(_cartIems.containsKey(productId)){
      _cartIems.update(productId,
              (exitingCart) => CartAttr(
          productName: exitingCart.productName,
          productId:exitingCart.productId,
          imageUrl: exitingCart.imageUrl,
          quantity: exitingCart.quantity+1,
          productQuantity: exitingCart.productQuantity,
          price: exitingCart.price,
          vendorId: exitingCart.vendorId,
          productSize: exitingCart.productSize,
          scheduleDate: exitingCart.scheduleDate
      ));
      notifyListeners();
    }else{
      _cartIems.putIfAbsent(productId, () =>
          CartAttr(productName: productName,
              productId: productId,
              imageUrl: imageUrl,
              quantity: quantity,
              productQuantity: productQuantity,
              price: price,
              vendorId: vendorId,
              productSize: productSize,
              scheduleDate: scheduleDate));
      notifyListeners();
    }

  }

  void increment(CartAttr cartAttr){
    cartAttr.increase();
    notifyListeners();
  }

  void decrement(CartAttr cartAttr){
    cartAttr.decrease();
    notifyListeners();
  }

  removeItem(productId){
    _cartIems.remove(productId);
    notifyListeners();
  }

  removeAllItem(){
    _cartIems.clear();
    notifyListeners();
  }



}