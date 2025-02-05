
import 'package:ez_navy_app/controller/auth/auth_controller.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/custom_input_widget.dart';

class LoginPage extends StatelessWidget{

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    double width=size.width;
    double height =size.height;
    return
      Scaffold(
        body: 
        SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    height: 48/30,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(11, 34, 62, 1),
                  ),
                ),
                const Text(
                  'Enter your credential to continue',
                  style: TextStyle(
                    height: 20.16/16,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(75, 75, 75, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: FormSection(),
                ),
              ],
            ),
          ),
        )
      );
    
  }
}


class FormSection extends StatelessWidget {

  FormSection({super.key});
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInputWidget(
              controller: controller.usernameController,
              hintText: 'Email',
              validator: (value) => value == null || value.isEmpty ? 'Email is required' : null,
              height: height * 0.070,
              width: width * 0.92,
            ),
            SizedBox(height: height * 0.020),
            CustomInputWidget(
              controller: controller.passwordController,
              hintText: 'Password',
              isPassword: true,
              validator: (value) => value == null || value.isEmpty ? 'Password is required' : null,
              height: height * 0.070,
              width: width * 0.92,
            ),
            SizedBox(height: height * 0.020),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator(color: Color.fromRGBO(11, 32, 62, 1))
                : SizedBox(
                    width: width * 0.92,
                    height: height * 0.070,
                    child: TextButton(
                      onPressed: controller.login,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(11, 34, 62, 1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: const Text('Log in'),
                    ),
                  ))
          ],
        ),
      )
    ;
  }
}