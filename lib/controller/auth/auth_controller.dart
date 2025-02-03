import 'dart:convert';
import 'dart:developer';

import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/jwt_builder.dart';
import 'package:ez_navy_app/model/user_model/user_model.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/services/auth/auth_services.dart';
import 'package:ez_navy_app/widgets/modal.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  final AuthServices _authServices = AuthServices();
  final _globalDataManager = GlobalDataManager();

  Future<void> login() async {

    final jwtToken = await jwtBuilderFunction(empEmail: 'abdulmajida@sedco.com');

    await _globalDataManager.setJwtJsonToken(jwtToken);

    final res = '';
    
    // if (res.status == true) {
    //   pushNamed(routeName: RoutesName.produtcsPage);
      
    // } else {
      
    //   log('OOOOO' + res.errorMessage.toString());
    //   CustomModal(
    //     title: 'Error',
    //     content: res.errorMessage!,
    //     rightButtonText: 'Ok',
    //     rightButtonOnClick: ()=>pop(),
    //   );
    // }

  }

}