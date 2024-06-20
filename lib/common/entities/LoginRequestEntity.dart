class LoginRequestEntity {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final Address address;

  LoginRequestEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'address': address.toJson(),
  };
}

class Address {
  final String street;
  final String houseNumber;
  final String zipCode;

  Address({
    required this.street,
    required this.houseNumber,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() => {
    'street': street,
    'houseNumber': houseNumber,
    'zipCode': zipCode,
  };
}