import 'package:ez_navy_app/constant/api_url.dart';
import 'package:ez_navy_app/model/user_model.dart';
import 'package:ez_navy_app/services/api/http_services.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  HttpService httpService = HttpService();

  var isLoading = false.obs;
  var users = <UsersModel>[].obs;

    @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    final fetchUsers = await httpService.apiGetRequest(ApiUrls.baseUrl + ApiUrls.forUser);
    
    if (fetchUsers.status == true) {
      final data = fetchUsers.data;
      if (data != null && data.containsKey("data")) {
        var usersList = (data["data"] as List)
            .map((user) => UsersModel.fromJson(user))
            .toList();
        
        users.assignAll(usersList);

        // for(var user in users){
        //   print(user.firstName);
        // }

      }
      isLoading.value = false;
    } else {
      isLoading.value = true;
      showError(fetchUsers.errorMessage!);
    }
  }



}