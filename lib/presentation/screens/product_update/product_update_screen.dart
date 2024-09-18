import 'dart:convert';

import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_app_bar.dart';
import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_floating_action_button.dart';
import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProductUpdateScreen extends StatefulWidget {
  final dynamic product;
  const ProductUpdateScreen({super.key, this.product});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  bool isLoading = false;
  final _globalKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productPriceController = TextEditingController();
  final productUnitPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    imageController.text = widget.product.productImage;
    productCodeController.text = widget.product.productCode;
    productNameController.text = widget.product.productName;
    productQuantityController.text = widget.product.productQuantity;
    productPriceController.text = widget.product.productTotalPrice;
    productUnitPriceController.text = widget.product.productUnitPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarName: "Update Product",
          isBackEnabled: true,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _globalKey,
                child: ListView(
                  children: [
                    CustomInputField(
                      controllerName: imageController,
                      hintText: "Write Image Link",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write Image Link";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      controllerName: productCodeController,
                      hintText: "Write Product Code",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write Product Code";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      controllerName: productNameController,
                      hintText: "Write Product Name",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write Product Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      controllerName: productQuantityController,
                      hintText: "Write Product Quantity",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write Product Quantity";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      controllerName: productPriceController,
                      hintText: "Write Product Price",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write Product Price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInputField(
                      controllerName: productUnitPriceController,
                      hintText: "Write Product Unit Price",
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write Product Unit Price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.check,
        onPressed: () async {
          if (_globalKey.currentState!.validate()) {
            await updateProduct(widget.product.id);
          } else {
            Fluttertoast.showToast(
                msg: "Please Fill Up All Required Fields",
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
        },
      ),
    );
  }

  Future<void> updateProduct(String productId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final url = "http://164.68.107.70:6060/api/v1/UpdateProduct/$productId";
      final headers = {
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> requestBody = {
        "Img": imageController.text,
        "ProductCode": productCodeController.text,
        "ProductName": productNameController.text,
        "Qty": productQuantityController.text,
        "TotalPrice": productPriceController.text,
        "UnitPrice": productUnitPriceController.text
      };
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(requestBody), headers: headers);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Product Update Complete",
            backgroundColor: Colors.red,
            textColor: Colors.white);
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    imageController.clear();
    productCodeController.clear();
    productNameController.clear();
    productQuantityController.clear();
    productPriceController.clear();
    productUnitPriceController.clear();
  }
}
