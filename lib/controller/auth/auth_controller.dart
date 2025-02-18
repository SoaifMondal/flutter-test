import 'dart:convert';
import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController with InputValidationMixin {

  var loginFormKey = GlobalKey<FormState>();
  var registrationFormKey = GlobalKey<FormState>();

  final timeoutDuration = const Duration(seconds: 90);
  var isLogin = true.obs;
  var isLoading = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController newUserNameController = TextEditingController();
  final TextEditingController newUserPasswordController =
      TextEditingController();
  final TextEditingController newUserconfirmPasswordController =
      TextEditingController();


  void changeAuthType() {
    isLogin.value = !isLogin.value;
  }

  Future<void> login() async {

    var userCredintialMatched = false;
    String? userId;

    final String username = usernameController.text;
    final String password = passwordController.text;

    if (loginFormKey.currentState?.validate() ?? false) {

      showLoader();

      try{
        final response = await http.get(Uri.parse('https://67ab131865ab088ea7e88ae4.mockapi.io/api/v2/UserCredentials'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(response.body);
          for(var user in data){
            if(user['useremail'] == username && user['password'] == password){
              userCredintialMatched = true;
              userId = user['id'];
              break;
            }
          }
          if(userCredintialMatched == true && userId != null){
            await GlobalDataManager().setuserId(userId);
            hideLoader();
            pushReplacement(routeName: RoutesName.produtcsPage);
          }else{
            hideLoader();
            showError('Wrong user credentials');
            return;
          }
        }else{
          hideLoader();
          showError('Login faild');
        }
      }catch(e){
        print('An error uquried while login. $e');
        hideLoader();
      }finally{}

    } else {
      showError('Valid Username and Password are required.');
    }
  }

  Future<void> registration() async {

    var userNameExit = false;
    final String newUserName = newUserNameController.text;
    final String newUserPassword = newUserPasswordController.text;

    if ( registrationFormKey.currentState?.validate() ?? false) {

      showLoader();

      try {
        final response = await http.get(
          Uri.parse(
              'https://67ab131865ab088ea7e88ae4.mockapi.io/api/v2/UserCredentials'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(response.body);
           for(var user in data){
            if(user['useremail'] == newUserName){
              userNameExit = true;
              showError('Email id already exits.');
              hideLoader();
              break;
            }
          }
        }
      } catch (e) {
        // print(e);
      } finally {}

    if(!userNameExit){

      try {
        Map<String, String> bodyData = {
          'useremail': newUserName,
          'password': newUserPassword
        };

        final response = await http.post(
          Uri.parse(
              'https://67ab131865ab088ea7e88ae4.mockapi.io/api/v2/UserCredentials'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(bodyData)
        );

        if (response.statusCode == 201) {
          final data = jsonDecode(response.body);
          // print(data);
          final userId = data['id'];
          // print('userID: ${userId}');
          
          hideLoader();
          await GlobalDataManager().setuserId(userId);
          pushReplacement(routeName: RoutesName.produtcsPage);

        }
      } catch (e) {
        print(e);
        hideLoader();
      } finally {}
    }



    } else {
      showError('All fields are required');
    }
  }

  void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

// Show Loader Function
void showLoader() {

  Get.dialog(
    const PopScope(
      canPop: false, // Prevent back button
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
    barrierDismissible: false, // Prevent tapping outside to dismiss
  );
}

// Hide Loader Function
void hideLoader() {
  if (Get.isDialogOpen ?? false) {
    Get.back(); // Close the loader
  }
}