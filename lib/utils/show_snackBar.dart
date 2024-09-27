import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';


showSnackBarWarning(context,String title){
  AnimatedSnackBar.material(
    title,
    type: AnimatedSnackBarType.warning,
  ).show(context);
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //       content: Text(title)
  //   )
  //     );
  
}

showSnackBarSucess(context,String title){
  AnimatedSnackBar.material(
    title,
    type: AnimatedSnackBarType.success,
  ).show(context);
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //       content: Text(title)
  //   )
  //     );

}