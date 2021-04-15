import 'package:firebase_crud/src/controller/authController.dart';
import 'package:firebase_crud/src/screen/home.dart';
import 'package:firebase_crud/src/screen/login.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().user != null) ? HomeScreen() : Login();
    });
  }
}
