import 'package:ez_navy_app/constant/api_url.dart';
import 'package:ez_navy_app/model/user_model.dart';
import 'package:ez_navy_app/services/api/http_services.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController{
  HttpService httpService = HttpService();

  var isLoading = false.obs;
  var user = Rxn<UsersModel>();



  Future<void> fetchUser(int userId) async {
    isLoading.value = true;

    final response =
        await httpService.apiGetRequest('${ApiUrls.baseUrl}${ApiUrls.forUser}/$userId');

    if (response.status == true) {
      final data = response.data;
      print(data);

      user.value = UsersModel.fromJson(data['data']);

 
    } else {
      isLoading.value = false;
      showError(response.errorMessage!);
    }
    
    isLoading.value = false;
  }
}
