import 'package:e_commerce/pages/sign_in/bloc/sign_in_events.dart';
import 'package:e_commerce/pages/sign_in/bloc/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<UsernameEvent>(_emailEvent);

    on<PasswordEvent>(_passwordEvent);
  }

  void _emailEvent(UsernameEvent event, Emitter<SignInState> emit) {
    //print("my email is ${event.email}");
    emit(state.copyWith(username: event.username));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    // print("my password is ${event.password}");
    emit(state.copyWith(password: event.password));
  }
}
