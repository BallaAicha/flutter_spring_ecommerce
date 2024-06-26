import 'package:e_commerce/common/entities/OrderResponseEntity.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderResponseEntity> orders;

  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String error;

  OrderError(this.error);
}