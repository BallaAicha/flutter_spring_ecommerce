import 'package:e_commerce/common/entities/ProductResponse.dart';

abstract class SearchEvents {}

class TriggerSearchEvents extends SearchEvents {
  TriggerSearchEvents(this.productItem);

  final List<ProductResponse> productItem;
}
