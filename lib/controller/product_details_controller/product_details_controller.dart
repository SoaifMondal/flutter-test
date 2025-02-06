import 'package:ez_navy_app/model/product_model/product_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailsController extends GetxController {
  var product = Rxn<ProductModel>(); // Holds the product details
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    int productId = Get.arguments;  // Get product ID from the previous screen
    fetchProductDetails(productId);
  }

  Future<void> fetchProductDetails(int id) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));

      if (response.statusCode == 200) {
        product.value = ProductModel.fromJson(json.decode(response.body));
      } else {
        Get.snackbar("Error", "Failed to load product details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}
