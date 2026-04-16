import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../core/networking/dio.helper.dart';
import '../model/order_SuccessModel.dart';
import 'order_success_state.dart';

class OrderSuccessCubit extends Cubit<OrderSuccessState> {
  OrderSuccessCubit() : super(OrderSuccessInitial());

  Future<void> getOrderSuccess() async {
    emit(OrderSuccessLoading());

    try {
      final response = await DioHelper.dio!.get("checkout");

      final data = OrderSuccessModel.fromJson(response.data);

      emit(OrderSuccessSuccess(data));
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
      emit(OrderSuccessError(
        e.response?.data["message"] ?? "Server Error",
      ));
    } catch (e) {
      print("Error: $e");
      emit(OrderSuccessError("Something went wrong"));
    }
  }
}