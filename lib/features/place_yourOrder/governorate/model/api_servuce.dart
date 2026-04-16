import 'dart:convert';
import 'package:http/http.dart' as http;
import 'gov_nerate.dart';

class ApiService {
  Future<List<Governorate>> getGovernorates() async {
    final response = await http.get(
      Uri.parse("https://codingarabic.online/api/governorates"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      List list = data['data']??[];

      return list.map((e) => Governorate.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load governorates");
    }
  }
}