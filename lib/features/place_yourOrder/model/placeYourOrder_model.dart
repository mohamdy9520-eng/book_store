class OrderModel {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String governorate;
  final double total;

  OrderModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.governorate,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "phone": phone,
      "governorate": governorate,
      "total": total,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      name: json["name"],
      email: json["email"],
      address: json["address"],
      phone: json["phone"],
      governorate: json["governorate"],
      total: (json["total"] as num).toDouble(),
    );
  }
}