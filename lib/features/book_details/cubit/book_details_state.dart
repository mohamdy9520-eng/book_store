import '../data/book_model.dart';

abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsSuccess extends BookDetailsState {
  final BookModel book;
  BookDetailsSuccess(this.book);
}

class BookDetailsError extends BookDetailsState {
  final String error;
  BookDetailsError(this.error);
}

class AddToCartLoading extends BookDetailsState {}

class AddToCartSuccess extends BookDetailsState {}

class AddToCartError extends BookDetailsState {
  final String error;
  AddToCartError(this.error);
}