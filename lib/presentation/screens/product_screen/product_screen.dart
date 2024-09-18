import 'dart:convert';

import 'package:crud_operation_flutter_assignment/model/product.dart';
import 'package:crud_operation_flutter_assignment/presentation/screens/product_create/product_create_screen.dart';
import 'package:crud_operation_flutter_assignment/presentation/screens/product_update/product_update_screen.dart';
import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_app_bar.dart';
import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoading = false;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarName: "Product List",
          isBackEnabled: false,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            )
          : productList.isEmpty
              ? const Center(
                  child: Text("No products available."),
                )
              : ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.productName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Colors.lightBlue,
                                  onPressed: () async {
                                    final isProductUpdated =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductUpdateScreen(
                                          product: product,
                                        ),
                                      ),
                                    );
                                    if (isProductUpdated == true) {
                                      getProduct();
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text("Code: ${product.productCode}"),
                            const SizedBox(height: 5),
                            Text("Price: \$${product.productUnitPrice}"),
                            const SizedBox(height: 5),
                            Text("Quantity: ${product.productQuantity}"),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total: \$${product.productTotalPrice}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    deleteProduct(product.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.add,
        onPressed: () async {
          final isProductCreated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductCreateScreen(),
            ),
          );

          if (isProductCreated == true) {
            getProduct();
          }
        },
      ),
    );
  }

  Future<void> getProduct() async {
    setState(() {
      isLoading = true;
    });
    try {
      const url = "http://164.68.107.70:6060/api/v1/ReadProduct";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        productList.clear();
        setState(() {
          productList = (jsonResponse["data"] as List)
              .map((product) => Product.fromJson(product))
              .toList();
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteProduct(String productId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final url = "http://164.68.107.70:6060/api/v1/DeleteProduct/$productId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse["data"]?["acknowledged"]) {
          await getProduct();
          Fluttertoast.showToast(
              msg: "Product Delete Complete",
              backgroundColor: Colors.green,
              textColor: Colors.white);
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
