import 'ProductResponse.dart';

class FavorisResponse {
  final int id;
  final List<ProductResponse> productList;

  FavorisResponse({
    required this.id,
    required this.productList,
  });

  factory FavorisResponse.fromJson(Map<String, dynamic> json) {
    return FavorisResponse(
      id: json['id'],
      productList: (json['productList'] as List)
          .map((product) => ProductResponse.fromJson(product))
          .toList(),
    );
  }
}