import '../model/order_SuccessModel.dart';

abstract class OrderSuccessState {
}

class OrderSuccessInitial extends OrderSuccessState {}

class OrderSuccessLoading extends OrderSuccessState {}

class OrderSuccessSuccess extends OrderSuccessState {

  @override
  final OrderSuccessModel data;

  OrderSuccessSuccess(this.data);
}

class OrderSuccessError extends OrderSuccessState {
  final String error;

  OrderSuccessError(this.error);
}