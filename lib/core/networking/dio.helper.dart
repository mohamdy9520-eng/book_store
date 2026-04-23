import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl:"https://codingarabic.online/api/",
        headers: {
          "Authorization": "Bearer YOUR_TOKEN",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query, required String token, required String url,
  }) async {
    return await dio!.get(
      endPoint,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.post(
      endPoint,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData(String s, Map<String, String>name, email, {
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query, required String url, required String token,
  }) async {
    return await dio!.put(
      endPoint,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? query, required String url,
  }) async {
    return await dio!.delete(
      endPoint,
      queryParameters: query,
    );
  }
}