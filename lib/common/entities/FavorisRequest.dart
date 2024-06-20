import 'ProductRequest.dart';

class FavorisRequest {
  final int id;
  final List<ProductRequest> productList;

  FavorisRequest({
    required this.id,
    required this.productList,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'productList': productList.map((product) => product.toJson()).toList(),
  };
}