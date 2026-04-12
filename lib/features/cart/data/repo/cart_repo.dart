import 'package:book_store/core/networking/api_constants.dart';
import 'package:book_store/core/networking/dio.helper.dart';

class CartRepo {

  static Future<bool> addToCart(int productId)async{
    try{
      final response=await DioHelper.dio?.post(ApiConstants.addToCart,
        data: {
        "product_id":productId
        }
      );
      if(response?.statusCode==201 || response?.statusCode==200 ){
        return true;
      }else{
        return false;
      }
    }catch(e){
      print("ERROR: $e");
      return false;
    }
  }
}