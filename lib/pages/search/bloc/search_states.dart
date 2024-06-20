import 'package:e_commerce/common/entities/ProductResponse.dart';

class SearchStates {
  const SearchStates({this.productItem = const <ProductResponse>[]});

  final List<ProductResponse> productItem;

  SearchStates copyWith({List<ProductResponse>? productItem}) {
    return SearchStates(productItem: productItem ?? this.productItem);
  }
}
