import 'package:e_commerce/common/entities/OrderRequestEntity.dart';
import 'package:e_commerce/common/entities/OrderResponseEntity.dart';
import 'package:e_commerce/pages/orders/bloc/OrderEvent.dart';
import 'package:e_commerce/pages/orders/bloc/OrderState.dart';
import 'package:e_commerce/pages/orders/order_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderControlller orderController;

  OrderBloc(this.orderController) : super(OrderInitial()) {
    on<AddOrderEvent>(_addToorders);
    on<LoadOrdersEvent>(_loadOrders);

  }
  // OrderBloc
  void _addToorders(
      AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      var orderRequest = OrderRequestEntity(
          amount: event.order.amount,
          paymentMethod: event.order.paymentMethod,
          customerId: event.order.customerId,
          products: event.order.products);
      if (orderController != null) {
        var response = await orderController.addOrder(orderRequest);
        if (response != null) {
          emit(OrderLoaded([response as OrderResponseEntity]));  // Cast to OrderResponseEntity
        } else {
          emit(OrderError("Response from addOrder was null"));
        }
      } else {
        emit(OrderError("OrderController is null"));
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }

  }

  void _loadOrders(
      LoadOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      var orders = await orderController.getOrders(event.customerId);
      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

}