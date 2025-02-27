import 'package:ez_navy_app/constant/api_url.dart';
import 'package:ez_navy_app/model/api_base_data_model.dart';
import 'package:ez_navy_app/model/user_model.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/services/api/http_services.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userCreateupdateController extends GetxController
    with InputValidationMixin {
  HttpService httpService = HttpService();

  var createUserFormKey = GlobalKey<FormState>();
  var updateUserFormKey = GlobalKey<FormState>();

  final timeoutDuration = const Duration(seconds: 90);

  var isLoading = false.obs;

  final TextEditingController userFirstnameController = TextEditingController();
  final TextEditingController userLastnameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();

  final TextEditingController updateuserFirstnameController =
      TextEditingController();
  final TextEditingController updateuserLastnameController =
      TextEditingController();
  final TextEditingController updateuserEmailController =
      TextEditingController();

  // create
  Future<void> createUser() async {
    final String userFirstName = userFirstnameController.text;
    final String userLastName = userLastnameController.text;
    final String userEmail = userEmailController.text;

    if (createUserFormKey.currentState?.validate() ?? false) {
      showLoader();

      final newUser = UsersModel(
          id: null,
          email: userEmail,
          firstName: userFirstName,
          lastName: userLastName,
          avatar: '');

      final registcreateuserdata = await httpService.apiPostRequest(
          ApiUrls.baseUrl + ApiUrls.forUser, newUser.toJson());

      if (registcreateuserdata.status == true) {
        final data = registcreateuserdata.data;

        hideLoader();
        showSuccess("User created successfully!");

        Get.dialog(
          AlertDialog(
            title: Text("User Created"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID: ${data['id']}"),
                Text("Email: ${data['email']}"),
                Text("First Name: ${data['first_name']}"),
                Text("Last Name: ${data['last_name']}"),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text("OK")),
            ],
          ),
        );
      } else {
        hideLoader();
        showError(registcreateuserdata.errorMessage!);
      }
    } else {
      showError('Valid Username and Password are required.');
    }
  }

  // update
  Future<void> updateUser(int id) async {
    print(id);
    final String userFirstName = updateuserFirstnameController.text;
    final String userLastName = updateuserLastnameController.text;
    final String userEmail = updateuserEmailController.text;

    if (updateUserFormKey.currentState?.validate() ?? false) {
      showLoader();

      final updateUser = UsersModel(
          id: id,
          email: userEmail,
          firstName: userFirstName,
          lastName: userLastName,
          avatar: '');

      final registUpdateuserdata = await httpService.apiPutRequest(
          '${ApiUrls.baseUrl}${ApiUrls.forUser}/$id', updateUser.toJson());

      if (registUpdateuserdata.status == true) {
        final data = registUpdateuserdata.data;

        hideLoader();
        showSuccess("User created successfully!");

        Get.dialog(
          AlertDialog(
            title: Text("User Created"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID: ${data['id']}"),
                Text("Email: ${data['email']}"),
                Text("First Name: ${data['first_name']}"),
                Text("Last Name: ${data['last_name']}"),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text("OK")),
            ],
          ),
        );
      } else {
        hideLoader();
        showError(registUpdateuserdata.errorMessage!);
      }
    } else {
      showError('Valid Username and Password are required.');
    }
  }
}
