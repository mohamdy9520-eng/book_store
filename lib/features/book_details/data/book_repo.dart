import 'package:book_store/features/book_details/data/book_model.dart';
import 'package:dio/dio.dart';

class BookRepo {
  static final Dio dio=Dio();

  static Future<BookModel>getBookDetails(int id)async{
    final response=await dio.get(
      "https://codingarabic.online/api"
    );
    return BookModel.fromJson(response.data);

  }
}