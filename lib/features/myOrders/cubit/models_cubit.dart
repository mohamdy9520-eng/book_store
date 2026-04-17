import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/networking/dio.helper.dart';
import '../../place_yourOrder/model/placeYourOrder_model.dart';
import 'models_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> getOrders() async {
    emit(OrderLoading());

    try {
      final response = await DioHelper.dio!.get("orders");

      final List ordersList = response.data["data"];

      final orders = ordersList.map((e) => OrderModel.fromJson(e)).toList();

      emit(OrderSuccess(orders));

    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}