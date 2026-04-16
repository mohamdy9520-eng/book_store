class OrderSuccessModel {
  final String message;

  OrderSuccessModel({required this.message});

  factory OrderSuccessModel.fromJson(Map<String, dynamic> json) {
    return OrderSuccessModel(
      message: json['message'] ?? '',
    );
  }
}