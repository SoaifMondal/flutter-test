import 'package:ez_navy_app/model/product_model/product_model.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ProductDetailsController extends GetxController {
  late int productId;
  var product = Rxn<ProductModel>();
  RxBool isLoading = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();

  //   print('Insoide the product deatils Page');
  //   if (arg is ProductArgument) {

  //     productId = arg.productID; 
  //     print('Product Id: $productId');
  //     fetchProductDetails(productId);

  //   } else {
  //     Get.snackbar("Error", "Invalid product argument");
  //     isLoading.value = false;
  //   }
  // }

  void getProductId(int id){
    productId = id;
    fetchProductDetails(productId);
  }

  Future<void> fetchProductDetails(int id) async {
    try {
      isLoading.value = true; 

      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Product : $jsonData');
        product.value = ProductModel.fromJson(jsonData); 
      } else {
        Get.snackbar("Error", "Failed to load product details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

