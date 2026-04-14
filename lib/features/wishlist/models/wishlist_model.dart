import 'dart:convert';

class WishlistItem {
  final int id;
  final String name;
  final String image;
  final String price;

  WishlistItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItem.fromJson(String source) =>
      WishlistItem.fromMap(json.decode(source));
}