class BookModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final String category;
  final double discount;
  final String product;

  BookModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.discount,
    required this.product
});
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      description: json['description'] ?? "",
      price: double.tryParse(json['Price'].toString())??0.0,
      category: json['category'] ?? "",
      discount: json['discount']??"",
      product: json['product']
    );
  }
}