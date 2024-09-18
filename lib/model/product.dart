class Product {
  final String id;
  final String productName;
  final String productCode;
  final String productImage;
  final String productUnitPrice;
  final String productQuantity;
  final String productTotalPrice;
  final String productCreatedDate;

  Product(
      {required this.id,
      required this.productName,
      required this.productCode,
      required this.productImage,
      required this.productUnitPrice,
      required this.productQuantity,
      required this.productTotalPrice,
      required this.productCreatedDate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["_id"],
        productName: json["ProductName"],
        productCode: json["ProductCode"],
        productImage: json["Img"],
        productUnitPrice: json["UnitPrice"],
        productQuantity: json["Qty"],
        productTotalPrice: json["TotalPrice"],
        productCreatedDate: json["CreatedDate"]);
  }
}
