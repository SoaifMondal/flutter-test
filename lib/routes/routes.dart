import 'package:ez_navy_app/main.dart';
import 'package:ez_navy_app/pages/home_page.dart';
import 'package:ez_navy_app/pages/login_page.dart';
import 'package:ez_navy_app/pages/product_details.dart';
import 'package:ez_navy_app/pages/product_filterpage.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';

class OnGeneratedRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings route) {
    final args = route.arguments;

    switch (route.name) {
      case RoutesName.loginPage:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case RoutesName.produtcsPage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case RoutesName.productDeatilsPage:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailsPage(),
        );
      case RoutesName.productFilter:
        return MaterialPageRoute(
          builder: (_) => const ProductFilterPage(),
        );

      default:
    }
    return null;
  }
}

Future<Object?> pushNamed(
    {required String routeName, Object? arguments}) async {
  return await navigatorKey.currentState!.pushNamed(
    routeName,
    arguments: arguments,
  );
}

Future<Object?> pushReplacement(
    {required String routeName, Object? arguments}) async {
  return await navigatorKey.currentState!.pushReplacementNamed(
    routeName,
    arguments: arguments,
  );
}

Future<Object?> pushRemoveUntill(
    {required String routeName, Object? arguments}) async {
  return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
    routeName,
    (_) => false,
    arguments: arguments,
  );
}

void pop({Map<String, dynamic>? result}) {
  navigatorKey.currentState!.pop(result);
}