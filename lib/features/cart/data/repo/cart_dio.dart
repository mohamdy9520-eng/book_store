import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://127.0.0.1:8000/api/",
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  static Future<Response> getData(String url) async {
    return await dio.get(url);
  }

  static Future<Response> postData(String url, Map<String, dynamic> data) async {
    return await dio.post(url, data: data);
  }

  static Future<Response> putData(String url, Map<String, dynamic> data) async {
    return await dio.put(url, data: data);
  }

  static Future<Response> deleteData(String url) async {
    return await dio.delete(url);
  }
}