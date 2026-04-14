import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/data/models/best_seller_response.dart';
import '../models/wishlist_model.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial()) {
    loadWishlist();
  }

  List<WishlistItem> wishlist = [];

  Future<void> loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('wishlist') ?? [];

    wishlist = data.map((e) => WishlistItem.fromJson(e)).toList();

    emit(WishlistLoaded(List.from(wishlist)));
  }

  Future<void> saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();

    final data = wishlist.map((e) => e.toJson()).toList();

    await prefs.setStringList('wishlist', data);
  }

  void toggle(Product book) {
    final index = wishlist.indexWhere((e) => e.id == book.id);

    if (index >= 0) {
      wishlist.removeAt(index);
    } else {
      wishlist.add(
        WishlistItem(
          id: book.id ?? 0,
          name: book.name ?? "",
          image: book.image ?? "",
          price: book.price ?? "",
        ),
      );
    }

    saveWishlist();
    emit(WishlistLoaded(List.from(wishlist)));
  }

  bool isFav(int id) {
    return wishlist.any((e) => e.id == id);
  }

  void remove(int id) {
    wishlist.removeWhere((e) => e.id == id);
    saveWishlist();
    emit(WishlistLoaded(List.from(wishlist)));
  }

  void clear() {
    wishlist.clear();
    saveWishlist();
    emit(WishlistLoaded([]));
  }
}