import 'dart:convert';

import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_app_bar.dart';
import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_floating_action_button.dart';
import 'package:crud_operation_flutter_assignment/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  bool isLoading = false;
  final _globalKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productPriceController = TextEditingController();
  final productUnitPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarName: "Create Product",
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
            await createProduct();
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

  Future<void> createProduct() async {
    setState(() {
      isLoading = true;
    });
    try {
      const url = "http://164.68.107.70:6060/api/v1/CreateProduct";
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
            msg: "Product Created Complete",
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
