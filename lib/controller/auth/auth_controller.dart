import 'package:ez_navy_app/constant/api_url.dart';
import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/model/api_base_data_model.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/services/api/http_services.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with InputValidationMixin {

  HttpService httpService = HttpService();

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

  // Login function
  Future<void> login() async {

    var userCredintialMatched = false;
    String? userId;
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (loginFormKey.currentState?.validate() ?? false) {

      showLoader();
      
      final registeredUserData = await httpService.apiGetRequest(ApiUrls.baseUrl+ ApiUrls.usreCredentials);

      if(registeredUserData.status == true){
        final data = registeredUserData.data;
        for(var user in data){
          if(user['useremail'] == username && user['password'] == password){
            userId = user['id'];
            userCredintialMatched = true;
            break;
          }
        }

        if(userCredintialMatched == true){
          await GlobalDataManager().setuserId(userId!);
            hideLoader();
            pushReplacement(routeName: RoutesName.produtcsPage);
        }else{
          hideLoader();
          showError('wrong user credentials');
        }

      }else{
        hideLoader();
        showError(registeredUserData.errorMessage!);
      }

    } else {
      showError('Valid Username and Password are required.');
    }
  }

  // Registration function 
  Future<void> registration() async {

    var userNameExit = false;
    String userId;
    final String newUserName = newUserNameController.text;
    final String newUserPassword = newUserPasswordController.text;

    if ( registrationFormKey.currentState?.validate() ?? false) {

      showLoader();
      
      final ApiBaseDataModel registeredUserData = await httpService.apiGetRequest(ApiUrls.baseUrl+ ApiUrls.usreCredentials);
      // print('user data: ${registeredUserData.data}');
      // print('API status: ${registeredUserData.status}');

      if(registeredUserData.status == true){

        final  data = registeredUserData.data;

        for(var user in data){
            if(user['useremail'] == newUserName){
              userNameExit = true;
              hideLoader();
              showError('Email id already exits.');
              break;
            }
          }
      }else{
        hideLoader();
        showError(registeredUserData.errorMessage!);
      }

      if(userNameExit == false){
        Map<String, String> bodyData = {
          "useremail": newUserName,
          "password": newUserPassword
        };
        final ApiBaseDataModel registerUser = await httpService.apiPostRequest(ApiUrls.baseUrl+ ApiUrls.usreCredentials, bodyData);

        if(registerUser.status == true){
          
          userId = registerUser.data['id'];
          // print('Usre ID: ${userId}');
          // print('Usre Data: ${registerUser.data}');

          await GlobalDataManager().setuserId(userId);

          hideLoader();
          pushReplacement(routeName: RoutesName.produtcsPage);
        }else{
          showError('an error happend, please try after some time');
        }
      }

    } else {
      showError('All fields are required');
    }
    
  }
}
