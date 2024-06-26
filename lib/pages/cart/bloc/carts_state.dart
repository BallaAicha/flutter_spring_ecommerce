import 'package:e_commerce/common/entities/CartResponse.dart';

abstract class CartState {}
class CartInitial extends CartState {}
class CartLoading extends CartState {}
class CartLoaded extends CartState {
  final List<CartResponse> cartResponses;
  CartLoaded(this.cartResponses);
}

class CartError extends CartState {
  final String error;

  CartError(this.error);
}

