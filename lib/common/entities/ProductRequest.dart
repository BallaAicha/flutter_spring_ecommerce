class ProductRequest {
  int? productId;
  String? name;
  String? description;
  double? availableQuantity;
  double? price;
  int? categoryId;
  int? imageId;
  ///quantity double
  double? quantity;

  ProductRequest({
    this.productId,
    this.name,
    this.description,
    this.availableQuantity,
    this.price,
    this.categoryId,
    this.imageId,
    this.quantity,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    productId: json["id"],
    name: json["name"],
    description: json["description"],
    availableQuantity: json["availableQuantity"],
    price: json["price"],
    categoryId: json["categoryId"],
    imageId: json["imageId"],
    quantity: json["quantity"],

  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "description": description,
    "availableQuantity": availableQuantity,
    "price": price,
    "categoryId": categoryId,
    "imageId": imageId,
    "quantity": quantity,
  };
}