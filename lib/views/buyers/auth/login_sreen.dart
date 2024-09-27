import 'package:flutter/material.dart';
import 'package:stock_multi_vendors/controllers/auth_controller.dart';
import 'package:stock_multi_vendors/utils/show_snackBar.dart';
import 'package:stock_multi_vendors/views/buyers/main_screen.dart';

import '../../../constants/constant.dart';
import 'register_screen.dart';
class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey =  GlobalKey<FormState>();
  AuthController _controller = AuthController();
  late String email;
  late String password;
  bool _isLoding = false;


  _loginUsers() async {
    setState(() {
      _isLoding =  true;
    });
    if(_formkey.currentState!.validate()){
    String res =  await _controller.loginUsers(email, password);
      if(context.mounted){
        if(res == "success"){
          showSnackBarSucess(context, "You are Now Logged In");
          return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context){
                    return const MainScreen();
                  }
              )
          );
        }else{
          setState(() {
            _isLoding =false;
          });
          return showSnackBarWarning(context, res);

        }
      }

    }else{
      setState(() {
        _isLoding =false;
      });
      return showSnackBarWarning(context, 'Please fields must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              const Text(
                "Login Customer's Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Email field must not be empty";
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    email = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Email Address',


                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Password field must not be empty";
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    password = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Password',


                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  _loginUsers();

                },
                child: Container(
                  width: MediaQuery.of(context).size.width -40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Center(
                    child: _isLoding? const CircularProgressIndicator(
                      color:Colors.white ,
                    ): const Text(
                      'Login',
                      style: TextStyle(
                        letterSpacing: 5,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Need An Account?"),
                  TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context){
                                  return BuyerRegisterScreen();
                                }
                                )
                        );
                      },
                      child: const Text("Register")
                  )
                ],
              )
            ],
          ),
        ),
