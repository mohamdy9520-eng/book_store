import 'package:book_store/core/networking/api_constants.dart';
import 'package:book_store/core/networking/dio.helper.dart';
import 'package:book_store/features/home/data/models/best_seller_response.dart';

class SearchRepo {
  static Future<BestSellerResponse?> search({required String text}) async {
    try {
      final response = await DioHelper.dio?.get(
        ApiConstants.search,
        queryParameters: {
          "name": text,
        },
      );

      if (response?.statusCode == 200) {
        BestSellerResponse data =
        BestSellerResponse.fromJson(response!.data);
        return data;
      }
    } catch (e) {}

    return null;
  }
}