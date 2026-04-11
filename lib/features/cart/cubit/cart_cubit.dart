import 'package:bloc/bloc.dart';
import 'package:book_store/features/cart/model/cart_model.dart';
import 'package:book_store/features/home/data/models/best_seller_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<CartItem>cartItems=[];

  void addToCart(CartItem item){
    final index=cartItems.indexWhere((e)=>e.name==item.name);

    if(index != -1){
      cartItems[index].quantity++;
    }else{
      cartItems.add(item);
    }
    emit(CartLoaded(cartItems));
  }

  void removeFromCart(String itemId) {
    cartItems.removeWhere((item) => Product == itemId);
    emit(CartLoaded(List.from(cartItems)));
  }

  void updateQuantity(String itemId, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.name == itemId);

    if (index >= 0) {
      if (newQuantity <= 0) {
        removeFromCart(itemId); // احذف لو صفر
      } else {
        cartItems[index] = CartItem(
          name: cartItems[index].name,
          imageUrl: cartItems[index].imageUrl,
          price: cartItems[index].price,
          quantity: newQuantity,
        );
        emit(CartLoaded(List.from(cartItems)));
      }
    }
  }

  double get totalPrice{
    return cartItems.fold(0,(sum,item)=>sum+(item.price*item.quantity));
  }
}
