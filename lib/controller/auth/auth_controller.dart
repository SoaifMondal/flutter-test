import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/jwt_builder.dart';
import 'package:ez_navy_app/model/user_model/user_model.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/services/auth/auth_services.dart';
import 'package:ez_navy_app/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class AuthController extends GetxController {

  
  var isLoading = false.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
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
      showError('Username and Password are required.');
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