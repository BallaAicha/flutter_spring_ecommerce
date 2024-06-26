import 'ProductRequest.dart';

class OrderRequestEntity {
  final int? id;
  final String? reference;
  final double amount;
  final String paymentMethod;
  final String customerId;
  final List<ProductRequest> products;

  OrderRequestEntity({
    this.id,
    this.reference,
    required this.amount,
    required this.paymentMethod,
    required this.customerId,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'customerId': customerId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}