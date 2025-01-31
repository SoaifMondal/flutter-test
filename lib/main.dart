import 'package:ez_navy_app/global_data/global_data.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/login_page.dart';
import './pages/home_page.dart';
import './pages/product_details.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      // SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(241, 245, 250, 1),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: GlobalDataManager().getJwtJsonToken() != null ?
       RoutesName.produtcsPage : RoutesName.loginPage,
      onGenerateRoute: OnGeneratedRoutes.onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}



GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();