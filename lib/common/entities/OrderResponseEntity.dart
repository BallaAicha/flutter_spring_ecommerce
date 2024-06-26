import 'ProductRequest.dart';

class OrderResponseEntity {
  final int? id;
  final String? reference;
  final String paymentMethod;
  final String customerId;
  final List<ProductRequest> products;

  OrderResponseEntity({
    this.id,
    this.reference,
    required this.paymentMethod,
    required this.customerId,
    required this.products,
  });

  factory OrderResponseEntity.fromJson(Map<String, dynamic> json) {
    return OrderResponseEntity(
      id: json['id'],
      reference: json['reference'],
      paymentMethod: json['paymentMethod'],
      customerId: json['customerId'],
      products: json['products'] != null
          ? (json['products'] as List).map((product) => ProductRequest.fromJson(product)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'paymentMethod': paymentMethod,
      'customerId': customerId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}