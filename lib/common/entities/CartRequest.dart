import 'Product.dart';
class CartRequest{
  final int id;
  final List<Product> productList;
  final String customerId;

  CartRequest({
    required this.id,
    required this.productList,
    required this.customerId
});

  Map<String, dynamic> toJson() => {
    'id': id,
    'productList': productList.map((product) => product.toJson()).toList(),
    'customerId': customerId,
  };

 }