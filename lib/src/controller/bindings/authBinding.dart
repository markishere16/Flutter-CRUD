import 'package:firebase_crud/src/controller/authController.dart';
import 'package:get/get.dart';

class authBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
