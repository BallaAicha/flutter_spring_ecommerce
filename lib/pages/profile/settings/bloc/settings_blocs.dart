import 'package:e_commerce/pages/profile/settings/bloc/settings_events.dart';
import 'package:e_commerce/pages/profile/settings/bloc/settings_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBlocs extends Bloc<SettingsEvents, SettingStates> {
  SettingsBlocs() : super(const SettingStates()) {
    on<TriggerSettings>(_triggerSettings);
  }

  _triggerSettings(SettingsEvents event, Emitter<SettingStates> emit) {
    emit(const SettingStates());
  }
}
