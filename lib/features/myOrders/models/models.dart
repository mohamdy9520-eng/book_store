class OrderModel {
  final int id;
  final String date;
  final double total;

  OrderModel({
    required this.id,
    required this.date,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      date: json['created_at'],
      total: double.parse(json['total'].toString()),
    );
  }
}