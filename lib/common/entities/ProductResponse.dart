class ProductResponse {
  final int id;
  final String name;
  final String description;
  final double availableQuantity;
  final double price;
  final int categoryId;
  final String categoryName;
  final String categoryDescription;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.availableQuantity,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    required this.categoryDescription,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      availableQuantity: json['availableQuantity'].toDouble(),
      price: json['price'].toDouble(),
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'],
      categoryDescription: json['categoryDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'availableQuantity': availableQuantity,
      'price': price,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryDescription': categoryDescription,
    };
  }
}