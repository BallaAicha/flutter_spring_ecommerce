import 'ProductResponse.dart';
class CartResponse {
  final int id;
  final List<ProductResponse> productList;
  final String customerId;
  CartResponse({
    required this.id,
    required this.productList,
    required this.customerId,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      id: json['id'],
      productList: (json['productList'] as List)
          .map((product) => ProductResponse.fromJson(product))
          .toList(),
      customerId: json['customerId'],
    );
  }
}