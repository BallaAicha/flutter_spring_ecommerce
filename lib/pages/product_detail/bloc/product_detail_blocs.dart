import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_detail_events.dart';
import 'product_detail_states.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvents, ProductDetailStates> {
  ProductDetailBloc() : super(const ProductDetailStates()) {
    on<TriggerProductDetail>(_triggerCourseDetail);
  }

  void _triggerCourseDetail(
      TriggerProductDetail event, Emitter<ProductDetailStates> emit) {
    emit(state.copyWith(productResponse: event.productResponse));
  }
}
