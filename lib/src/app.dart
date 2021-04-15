import 'package:firebase_crud/src/controller/bindings/authBinding.dart';
import 'package:firebase_crud/src/screen/home.dart';
import 'package:firebase_crud/src/screen/login.dart';
import 'package:firebase_crud/src/utils/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: authBinding(),
      home: Scaffold(
        body: Root(),
      ),
    );
  }
}
