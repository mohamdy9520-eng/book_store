import 'package:book_store/core/helper/app_constants.dart';
import 'package:book_store/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,

        headers: {
          "Authorization": "Bearer ${AppConstants.token}",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          if (options.path.contains('/posts')) {
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
}