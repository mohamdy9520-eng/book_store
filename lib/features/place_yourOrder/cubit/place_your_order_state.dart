abstract class PlaceOrderState {
  get governorates => null;
}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoading extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {}

class PlaceOrderError extends PlaceOrderState {
  final String message;

  PlaceOrderError(this.message);
}