import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/src/controller/userController.dart';
import 'package:firebase_crud/src/models/user.dart';
import 'package:firebase_crud/src/service/database.dart';
import 'package:firebase_crud/src/utils/root.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  String get user => _firebaseUser.value?.email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser( String name,String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //create user in firestore
      //
      UserModel _user =
          UserModel(id: _authResult.user.uid, name: name, email: email);
      if (await Database().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Creating account', e.message);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar('Error Loggin account', authErrorHandler(e.code));
    }
  }

  void signout() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {}
  }

  authErrorHandler(error) {
    switch (error) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }
}
