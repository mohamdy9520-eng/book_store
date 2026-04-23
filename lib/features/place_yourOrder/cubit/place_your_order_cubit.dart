import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/networking/dio.helper.dart';
import '../governorate/model/gov_nerate.dart';
import '../model/placeYourOrder_model.dart';
import 'place_your_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  static const String ordersKey = "orders";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final totalController=TextEditingController();

  String? governorate;
  int? governorateId;
  Governorate? selectedGovernorate;

  final formKey = GlobalKey<FormState>();

  void changeGovernorate(String? value) {
    governorate = value;
    emit(PlaceOrderInitial());
  }

   Future<void> saveOrder(OrderModel order) async {
     print("Governorate ID => $governorateId");
     print("Type => ${governorateId.runtimeType}");
    final prefs = await SharedPreferences.getInstance();

    List<String> orders = prefs.getStringList(ordersKey) ?? [];
    orders.add(jsonEncode(order.toJson()));

    await prefs.setStringList(ordersKey, orders);
  }

  Future<void> placeOrder({required double total}) async {
    if (!formKey.currentState!.validate()) {
      emit(PlaceOrderError("Please fill all fields"));
      return;
    }

    if (governorate == null) {
      emit(PlaceOrderError("Please select governorate"));
      return;
    }

    emit(PlaceOrderLoading());

    try {
      final response = await DioHelper.dio!.post(ApiConstants.placeOrder,
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "address": addressController.text,
          "phone": phoneController.text,
          "governorate_id": governorateId,
          "total": total
        },
      );

      print("CHECKOUT SUCCESS => ${response.data}");

      emit(PlaceOrderSuccess());
    } on DioException catch (e) {
      print("CHECKOUT ERROR => ${e.response?.data}");
      emit(PlaceOrderError(e.response?.data["message"] ?? "Checkout failed"));
    }

  }
}