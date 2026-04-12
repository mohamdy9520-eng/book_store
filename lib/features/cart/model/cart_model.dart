class CartItem {
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  final String id;


  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.imageUrl,
    required this.id

  });
  CartItem copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}


