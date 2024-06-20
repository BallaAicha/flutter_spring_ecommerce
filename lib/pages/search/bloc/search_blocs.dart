import 'package:e_commerce/pages/search/bloc/search_events.dart';
import 'package:e_commerce/pages/search/bloc/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBlocs extends Bloc<SearchEvents, SearchStates> {
  SearchBlocs() : super(const SearchStates()) {
    on<TriggerSearchEvents>(_triggerSearchEvents);
  }

  _triggerSearchEvents(TriggerSearchEvents event, Emitter<SearchStates> emit) {
    emit(state.copyWith(productItem: event.productItem));
  }
}
