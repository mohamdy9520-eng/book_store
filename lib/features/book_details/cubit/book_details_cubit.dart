import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/book_model.dart';
import 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitial());

  BookModel? book;

  Future<void> getBook(int id) async {
    emit(BookDetailsLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response = await Dio().get(
        "https://codingarabic.online/api/$id",
      );


      final book = BookModel.fromJson(response.data);

      emit(BookDetailsSuccess(book));
    } catch (e) {
      emit(BookDetailsError("Failed to load book"));
    }
  }

  Future<void> addToCart() async {
    emit(AddToCartLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(AddToCartSuccess());

      emit(BookDetailsSuccess(book!));
    } catch (e) {
      emit(AddToCartError("Error adding to cart"));
      emit(BookDetailsSuccess(book!));
    }
  }
}