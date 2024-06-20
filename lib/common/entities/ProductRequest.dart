class ProductRequest {
  int? id;
  String? name;
  String? description;
  double? availableQuantity;
  double? price;
  int? categoryId;
  int? imageId;

  ProductRequest({
    this.id,
    this.name,
    this.description,
    this.availableQuantity,
    this.price,
    this.categoryId,
    this.imageId,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    availableQuantity: json["availableQuantity"],
    price: json["price"],
    categoryId: json["categoryId"],
    imageId: json["imageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "availableQuantity": availableQuantity,
    "price": price,
    "categoryId": categoryId,
    "imageId": imageId,
  };
}