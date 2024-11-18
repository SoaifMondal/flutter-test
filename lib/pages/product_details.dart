
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int productId;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get product ID passed via Navigator
    productId = ModalRoute.of(context)!.settings.arguments as int;

    // Fetch product details from API
    productDetails = fetchProductDetails(productId);
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
                  onTap: () { Navigator.pushNamed(context, '/home'); },
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



