import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/networking/dio.helper.dart';
import '../model/placeYourOrder_model.dart';
import 'place_your_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  static const String ordersKey = "orders";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  String? governorate;

  final formKey = GlobalKey<FormState>();

  void changeGovernorate(String? value) {
    governorate = value;
    emit(PlaceOrderInitial());
  }

  static Future<void> saveOrder(OrderModel order) async {
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
      await DioHelper.dio!.post(
        "place-order",
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "address": addressController.text,
          "phone": phoneController.text,
          "governorate": governorate,
          "total": total,
        },
      );

      final order = OrderModel(
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        phone: phoneController.text,
        governorate: governorate!,
        total: total,
      );

      await saveOrder(order);

      emit(PlaceOrderSuccess());
    } catch (e) {
      emit(PlaceOrderError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    return super.close();
  }
}