
class SliderResponse {
  final SliderData? data;
  final String? message;
  final List<dynamic>? error;
  final int? status;

  SliderResponse({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      data: json['data'] != null
          ? SliderData.fromJson(json['data'])
          : null,
      message: json['message'],
      error: json['error'] ?? [],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'error': error,
      'status': status,
    };
  }
}

class SliderData {
  final List<SliderItem>? sliders;

  SliderData({this.sliders});

  factory SliderData.fromJson(Map<String, dynamic> json) {
    return SliderData(
      sliders: json['sliders'] != null
          ? List<SliderItem>.from(
          json['sliders'].map((x) => SliderItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sliders': sliders?.map((x) => x.toJson()).toList(),
    };
  }
}

class SliderItem {
  final String? image;

  SliderItem({this.image});

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}
