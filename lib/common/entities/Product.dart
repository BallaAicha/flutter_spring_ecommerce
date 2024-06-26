class Product {
  int? id;
  String? name;
  String? description;
  double? availableQuantity;
  double? price;
  int? categoryId;
  int? imageId;
  ///quantity double
  double? quantity;

  Product({
    this.id,
    this.name,
    this.description,
    this.availableQuantity,
    this.price,
    this.categoryId,
    this.imageId,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    availableQuantity: json["availableQuantity"],
    price: json["price"],
    categoryId: json["categoryId"],
    imageId: json["imageId"],
    quantity: json["quantity"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "availableQuantity": availableQuantity,
    "price": price,
    "categoryId": categoryId,
    "imageId": imageId,
    "quantity": quantity,
  };
}