import 'package:e_commerce/common/entities/OrderRequestEntity.dart';

abstract class OrderEvent {}

class LoadOrdersEvent extends OrderEvent {
  final String customerId;
  LoadOrdersEvent(this.customerId);
}

class AddOrderEvent extends OrderEvent {
  final OrderRequestEntity order;
  AddOrderEvent(this.order);
}