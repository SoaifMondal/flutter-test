import 'package:ez_navy_app/main.dart';
import 'package:ez_navy_app/pages/cart_page.dart';
import 'package:ez_navy_app/pages/product_page.dart';
import 'package:ez_navy_app/pages/login_page.dart';
import 'package:ez_navy_app/pages/product_details.dart';
import 'package:ez_navy_app/pages/product_filterpage.dart';
import 'package:ez_navy_app/pages/user_create_&_update_page.dart';
import 'package:ez_navy_app/pages/user_details_page.dart';
import 'package:ez_navy_app/pages/user_listing_page.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:ez_navy_app/utils/core.dart';
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
          builder: (_) => ProductPage(),
        );
      case RoutesName.productDetailsPage:
        if (args is ProductArgument) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailsPage(productArgument: args),
          );
        }
      case RoutesName.productFilter:
        return MaterialPageRoute(
          builder: (_) => const ProductFilterPage(),
        );
      case RoutesName.cartPage:
        return MaterialPageRoute(
          builder: (_) =>  CartPage(), 
        );

      case RoutesName.userListingPage:
        return MaterialPageRoute(
          builder: (_) =>  UserListinPage(), 
        );
      case RoutesName.userDetailspage:
        return MaterialPageRoute(
          builder: (_) =>  UserDetailsPage(userID: args), 
        );
      case RoutesName.userCreatePage:
        return MaterialPageRoute(
          builder: (_) =>  UsercreateUpadtePage(type: true), 
        );
      case RoutesName.userUpdatePage:
        return MaterialPageRoute(
          builder: (_) =>  UsercreateUpadtePage(type: false), 
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