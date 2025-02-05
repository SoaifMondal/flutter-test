
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsPage extends StatefulWidget {

  final Map<String, dynamic> arguments;

  ProductDetailsPage({super.key, required this.arguments});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  late Future<Map<String, dynamic>> productDetails;
  bool isLoading = true;
  
  Future<Map<String, dynamic>> fetchProductDetails(int id) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int productId = widget.arguments['product_id'] ?? 0;

      setState(() {
        productDetails = fetchProductDetails(productId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width*.050, right: width*.050, top: height*0.070),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.zero, // Ensures no extra padding
                alignment: Alignment.centerLeft, // Aligns it with the start of the column
                child: GestureDetector(
                  onTap: () { pushNamed(routeName: RoutesName.produtcsPage); },
                  child: SvgPicture.asset('assets/images/Back.svg'),
                ),
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: productDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Padding(
                      padding: EdgeInsets.only(top: height*0.35),
                      child: const CircularProgressIndicator(),
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data found'));
                  }
              
                  final product = snapshot.data!;
              
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product['image']),
                      SizedBox(height: 16),
                      Text(
                        product['title'],
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$${product['price']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Category: ${product['category']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Description: ${product['description']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



