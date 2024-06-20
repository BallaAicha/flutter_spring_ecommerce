class SignInState {
  const SignInState({
    this.username = "",
    this.password = "",
  });

  final String username;
  final String password;

  SignInState copyWith({
    //optional named parameter
    String? username,
    String? password,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
