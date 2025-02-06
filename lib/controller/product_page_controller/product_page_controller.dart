import 'package:ez_navy_app/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPageController extends GetxController {
  var products = <ProductModel>[].obs;
  var categories = <String>[].obs;
  var isLoading = false.obs;
  var selectedCategory = Rxn<String>();
  var sortOrder = 'asc'.obs;
  var searchQuery = ''.obs;
  
  // Search Controller
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    if (isLoading.value) return;
    isLoading.value = true;

    const baseUrl = 'https://fakestoreapi.com/products';
    final url = selectedCategory.value != null
        ? '$baseUrl/category/${selectedCategory.value}?sort=${sortOrder.value}'
        : '$baseUrl?sort=${sortOrder.value}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var fetchedProducts = json.decode(response.body);
      
      // Filter products based on search query
      // if (searchQuery.value.isNotEmpty) {
      //   fetchedProducts = fetchedProducts
      //       .where((product) => product['title']
      //           .toString()
      //           .toLowerCase()
      //           .contains(searchQuery.value.toLowerCase()))
      //       .toList();
      // }

      if(fetchedProducts is List){
        print('product length ${fetchedProducts.length}');
        products.value = fetchedProducts.map((json)=> ProductModel.fromJson(json)).toList();
      }

    } else {
      Get.snackbar("Error", "Failed to load products");
    }
    isLoading.value = false;
  }

  Future<void> fetchCategories() async {
    final url = 'https://fakestoreapi.com/products/categories';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      categories.value = List<String>.from(json.decode(response.body));
    } else {
      Get.snackbar("Error", "Failed to load categories");
    }
  }

  void setCategory(String? category) {
    selectedCategory.value = category;
    fetchProducts();
  }

  void changeSortOrder(String order) {
    sortOrder.value = order;
    fetchProducts();
  }

  // void updateSearchQuery(String query) {
  //   searchQuery.value = query;
  //   fetchProducts();
  // }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
