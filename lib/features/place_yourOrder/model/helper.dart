import 'dart:convert';
import 'package:book_store/features/place_yourOrder/model/placeYourOrder_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String ordersKey = "orders";

  static Future<void> saveOrder(OrderModel order) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> orders = prefs.getStringList(ordersKey) ?? [];

    orders.add(jsonEncode(order.toJson()));

    await prefs.setStringList(ordersKey, orders);
  }

  static Future<List<OrderModel>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> orders = prefs.getStringList(ordersKey) ?? [];

    return orders.map((e) => OrderModel.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ordersKey);
  }
}