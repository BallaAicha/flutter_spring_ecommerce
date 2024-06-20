class LoginResponseEntity {
  String? id;

  LoginResponseEntity({
    this.id,
  });

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      LoginResponseEntity(
        id: json["body"]["id"],
      );
}


