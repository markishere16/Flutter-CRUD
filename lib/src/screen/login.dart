import 'package:firebase_crud/src/app.dart';
import 'package:firebase_crud/src/controller/authController.dart';
import 'package:firebase_crud/src/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    child: Text('Sign in'),
                    onPressed: () {
                      // if (emailController.text.trim().length == 0 ||
                      //     passwordController.text.length == 0) {
                      //   Get.snackbar(
                      //       'Error Login', 'Please fill up Email and password');
                      // } else {
                      //   controller.login(emailController.text.trim(),
                      //       passwordController.text);
                      // }
                      //
                    },
                  ),
                  RaisedButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      Get.to(SignUp());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
