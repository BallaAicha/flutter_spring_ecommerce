import 'package:e_commerce/common/entities/ProductResponse.dart';

class ProductDetailStates {
  const ProductDetailStates({
    this.productResponse,
  });

  final ProductResponse? productResponse;

  ProductDetailStates copyWith({ProductResponse? productResponse}) {
    return ProductDetailStates(
      productResponse: productResponse ?? this.productResponse,
    );
  }
}
