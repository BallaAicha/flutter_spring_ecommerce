import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_events.dart';
import 'app_states.dart';
class AppBlocs extends Bloc<AppEvent, AppState> {
  final String customerId; // Add customerId field

  AppBlocs(this.customerId) : super(AppState(customerId: customerId)) { // Update constructor
    on<TriggerAppEvent>((event, emit) {
      emit(AppState(index: event.index, customerId: customerId));
    });
  }
}