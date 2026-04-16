class Governorate {
  final int id;
  final String governorateNameEn;

  Governorate({
    required this.id,
    required this.governorateNameEn,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'],
      governorateNameEn: json['governorate_name_en'],
    );
  }
}