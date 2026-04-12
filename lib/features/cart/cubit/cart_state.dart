part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> items;
   CartLoaded(this.items);
}

final class CartSuccess extends CartState {
  final String message;
   CartSuccess([this.message = 'Success']);
}


final class CartError extends CartState {
  final String message;
   CartError({this.message="Failed"});
}

class RemoveFromCartLoadingState extends CartState {}

class RemoveFromCartSuccessState extends CartState {}

class RemoveFromCartErrorState extends CartState {
  final String message;
  RemoveFromCartErrorState(this.message);
}