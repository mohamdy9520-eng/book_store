class CartItem {
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  final int id;
  final String product;


  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.imageUrl,
    required this.id,
    required this.product

  });
  CartItem copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
    String? product
  }) {
    return CartItem(
      id: this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      product:product?? this.product
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "quantity": quantity,
      "imageUrl": imageUrl,
      "product": product,
    };
  }
}



