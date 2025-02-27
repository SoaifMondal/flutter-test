import 'package:ez_navy_app/constant/api_url.dart';
import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/model/api_base_data_model.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/services/api/http_services.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userCreateupdateController extends GetxController with InputValidationMixin {

  HttpService httpService = HttpService();

  var createUserFormKey = GlobalKey<FormState>();
  var updateUserFormKey = GlobalKey<FormState>();

  final timeoutDuration = const Duration(seconds: 90);

  var isLoading = false.obs;

  final TextEditingController userFirstnameController = TextEditingController();
  final TextEditingController userLastnameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();

  final TextEditingController updateuserFirstnameController = TextEditingController();
  final TextEditingController updateuserLastnameController = TextEditingController();
  final TextEditingController updateuserEmailController = TextEditingController();


  // create
  Future<void> createUser() async {

    final String userFirstName = userFirstnameController.text;
    final String userLastName = userLastnameController.text;
    final String userEmail = userEmailController.text;

    if (createUserFormKey.currentState?.validate() ?? false) {

      showLoader();
      
      final registcreateuserdata = await httpService.apiGetRequest(ApiUrls.baseUrl+ ApiUrls.forUser);

      if(registcreateuserdata.status == true){
        final data = registcreateuserdata.data;
        
        }else{
        hideLoader();
        showError(registcreateuserdata.errorMessage!);
      }

    } else {
      showError('Valid Username and Password are required.');
    }
  }


  // update
  Future<void> updateUser() async {


    final String userFirstName = userFirstnameController.text;
    final String userLastName = userLastnameController.text;
    final String userEmail = userEmailController.text;

    if (updateUserFormKey.currentState?.validate() ?? false) {

      showLoader();
      
      final registcreateuserdata = await httpService.apiGetRequest(ApiUrls.baseUrl+ ApiUrls.forUser);

      if(registcreateuserdata.status == true){
        final data = registcreateuserdata.data;
        
        }else{
        hideLoader();
        showError(registcreateuserdata.errorMessage!);
      }

    } else {
      showError('Valid Username and Password are required.');
    }
  }
 

}