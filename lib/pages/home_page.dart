
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/custom_input_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final TextEditingController _searchController = TextEditingController();

  List products = [];
  List categories = [];
  bool isLoading = false;
  String? selectedCategory; // For filtering
  String sortOrder = 'asc'; // Default sorting order

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final baseUrl = 'https://fakestoreapi.com/products';
    final url = selectedCategory != null
        ? '$baseUrl/category/$selectedCategory?sort=$sortOrder'
        : '$baseUrl?sort=$sortOrder';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchCategories() async {
    final url = 'https://fakestoreapi.com/products/categories';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                setState(() {
                  selectedCategory = category;
                });
                fetchProducts(); // Fetch products based on selected category and sorting
              },
            );
          },
        );
      },
    );
  }

  void showSortingOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Ascending'),
              onTap: () {
                Navigator.pop(context); // Close modal
                setState(() {
                  sortOrder = 'asc';
                });
                fetchProducts(); // Fetch products with ascending order
              },
            ),
            ListTile(
              title: const Text('Descending'),
              onTap: () {
                Navigator.pop(context); // Close modal
                setState(() {
                  sortOrder = 'desc';
                });
                fetchProducts(); // Fetch products with descending order
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: null,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
          top: height * 0.06,
          right: width * 0.05,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Color.fromRGBO(11, 34, 62, 1),
                  ),
                ),
                GestureDetector(
                  child: SvgPicture.asset('assets/images/sign-out-alt.svg'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context,'/');
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: const Text(
                'Product & Customer Credentials',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(75, 75, 75, 1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.020),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomInputWidget(
                    controller: _searchController,
                    hintText: 'Search By',
                    height: height * 0.050,
                    width: width * 0.66,
                    inputIcon: Icons.search,
                  ),
                  GestureDetector(
                    onTap: showSortingOptions,
                    child: SvgPicture.asset('assets/images/sorting.svg'),
                  ),
                  GestureDetector(
                    onTap: showCategoryFilter,
                    child: SvgPicture.asset('assets/images/filter.svg'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (selectedCategory != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Text(
                      'Category: $selectedCategory',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        selectedCategory = null;
                        sortOrder = 'asc';
                        fetchProducts();
                      }),
                      child: Text('X  Clear Filter'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Stack(
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        fetchProducts(); // Load more in the current sorting/category context
                      }
                      return false;
                    },
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 products per row
                        childAspectRatio: 0.59,
                      ),
                      itemCount: products.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == products.length && isLoading) {
                          return const Center();
                        }
                        final product = products[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
                  if (isLoading)
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/productDetails',
          arguments: product['id'],
        );
      },
      child: SizedBox(
        height: 200,
        child: Card(
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product['image'],
                    height: height * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.02),
                  child: Text(
                    product['title'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color.fromRGBO(156, 160, 175, 1)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: height * 0.02),
                  child: Text(
                    '\$${product['price']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
