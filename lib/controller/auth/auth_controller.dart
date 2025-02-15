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

  var emailErrorText = RxnString();
  var passwordError = RxnString();

  void changeAuthType() {
    isLogin.value = !isLogin.value;
  }

  bool validateForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }

  Future<void> login() async {
    validateForm();

    final String username = usernameController.text;
    final String password = passwordController.text;

    emailErrorText.value = validateEmail(username);
    passwordError.value = validatePassword(password);

    if (emailErrorText.value == null && passwordError.value == null) {
      isLoading.value = true;

      try {
        final response = await http.post(
          Uri.parse('https://app.ef-tm.com/v1//public/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"email": username, "password": password}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['data']['user']['accessToken'] != null) {
            final token = data['data']['user']['accessToken'];
            GlobalDataManager().setJwtJsonToken(token);
            pushReplacement(routeName: RoutesName.produtcsPage);
          } else {
            showError('Login failed. Please check your credentials.');
          }
        } else if (response.statusCode == 412) {
          showError('Login failed. Please enter correct user details.');
        }
      } catch (e) {
        showError('An error occurred. Please try again.');
      } finally {
        isLoading.value = false;
      }
    } else {
      showError('Valid Username and Password are required.');
    }
  }

  Future<void> registration() async {
    registrationFormKey.currentState?.validate();

    final String userName = newUserNameController.text;
    final String password = newUserPasswordController.text;
    final String confirmPassword = newUserconfirmPasswordController.text;

    if (userName.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showError('All fields are required');
    } else {
      try {
        final response = await http.get(
          Uri.parse(
              'https://67ab131865ab088ea7e88ae4.mockapi.io/api/v2/UserCredentials'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(response.body);
        }
      } catch (e) {
        print(e);
      } finally {}
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
