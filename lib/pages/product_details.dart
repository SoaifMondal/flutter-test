import 'package:ez_navy_app/controller/product_details_controller/product_details_controller.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {

  final ProductArgument productID;
  ProductDetailsPage({super.key, required this.productID});
  
  final ProductDetailsController controller = Get.put(ProductDetailsController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width * .050, right: width * .050, top: height * 0.070),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => pop(),
                child: Icon(Icons.arrow_back, size: 30),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.35),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (controller.product.value == null) {
                  return Center(child: Text('No product details found'));
                }

                final product = controller.product.value!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.image, height: 200, fit: BoxFit.cover),
                    SizedBox(height: 16),
                    Text(
                      product.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Category: ${product.category}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Description: ${product.description}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 40),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
