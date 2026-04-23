import 'package:dio/dio.dart';

import '../../../../core/helper/cach_helper.dart';
import '../../../../core/networking/dio.helper.dart';
import '../../../cart/model/cart_model.dart';

Future<void> checkout({
  required String name,
  required String email,
  required String address,
  required String phone,
  required String governorate,
  required double price,
  required List<CartItem> cartItems,
}) async {
  try {
    String token = CacheHelper.getData(key: "token");

    double total = cartItems.fold(
      0,
          (sum, item) => sum + item.price,
    );

    final response = await DioHelper.dio!.post(
      "checkout",
      data: {
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "Governorate": governorate,
        "total": total,

      },
      options: Options(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    print("CHECKOUT SUCCESS => ${response.data}");
  } catch (e) {
    print("CHECKOUT ERROR => $e");
  }
}