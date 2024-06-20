import '../../../common/entities/ProductResponse.dart';

class HomePageStates {
  const HomePageStates(
      {this.productItem = const <ProductResponse>[], this.index = 0});

  final int index;
  final List<ProductResponse> productItem;

  HomePageStates copyWith({int? index, List<ProductResponse>? productItem}) {
    return HomePageStates(
        productItem: productItem ?? this.productItem,
        index: index ?? this.index);
  }
}
