

import 'Product.dart';

class FavorisRequest {
  final int id;
  final List<Product> productList;
  final String customerId;

  FavorisRequest({
    required this.id,
    required this.productList,
    required this.customerId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'productList': productList.map((product) => product.toJson()).toList(),
    'customerId': customerId,
  };
}