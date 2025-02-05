import 'package:ez_navy_app/controller/auth/auth_controller.dart';
import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      // SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  getXControllerInit();
  await GlobalDataManager().initialize();

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    String? token = GlobalDataManager().getJwtJsonToken();
    print("JWT Token: $token"); // Debugging

    return GetMaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(241, 245, 250, 1),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: GlobalDataManager().getJwtJsonToken() == null ?
      RoutesName.loginPage : RoutesName.produtcsPage,
      onGenerateRoute: OnGeneratedRoutes.onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}



GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void getXControllerInit() {
  Get.lazyPut(() => AuthController());
}