import 'package:e_commerce/common/entities/CartRequest.dart';
import 'package:e_commerce/pages/cart/bloc/carts_event.dart';
import 'package:e_commerce/pages/cart/bloc/carts_state.dart';
import 'package:e_commerce/pages/cart/cart_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/entities/Product.dart';
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartController cartController;

  CartBloc(this.cartController) : super(CartInitial()) {
    on<AddToCartsEvent>(_addToCarts);
    on<LoadCartsEvent>(_loadFavorites);
  }

  void _addToCarts(
      AddToCartsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      var cartRequest = CartRequest(
          id: event.productId,
          productList: [Product(id: event.productId)],
          customerId: event.customerId);
      var response = await cartController.addCart(cartRequest);
      emit(CartLoaded([response]));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _loadFavorites(
      LoadCartsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      var response = await cartController.getCartsByCustomer(event.customerId); // pass customerId here
      emit(CartLoaded(response));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
