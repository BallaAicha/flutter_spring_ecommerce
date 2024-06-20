import '../../../common/entities/ProductResponse.dart';

abstract class HomePageEvents {
  const HomePageEvents();
}

class HomePageDots extends HomePageEvents {
  final int index;

  const HomePageDots(this.index) : super();
}

class HomePageProductItem extends HomePageEvents {
  const HomePageProductItem(this.productItem);

  final List<ProductResponse> productItem;
}
