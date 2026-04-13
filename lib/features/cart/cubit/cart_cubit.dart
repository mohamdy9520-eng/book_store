import 'package:bloc/bloc.dart';
import 'package:book_store/features/cart/model/cart_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoaded([]));

  List<CartItem> cartItems = [];

  void addToCart(CartItem item) {
    try {
      final index = cartItems.indexWhere((e) => e.id == item.id);

      if (index != -1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + 1,
        );
      } else {
        cartItems.add(item);
      }

      emit(CartLoaded(List.from(cartItems)));
    } catch (e) {
      emit(CartError(message: "Failed to add item to cart."));
    }
  }

  void removeFromCartById(int id) {
    try {
      cartItems.removeWhere((item) => item.id == id);
      emit(CartLoaded(List.from(cartItems)));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void updateQuantity(int id, int quantity) {
    final index = cartItems.indexWhere((e) => e.id == id);

    if (index != -1) {
      cartItems[index].quantity = quantity;
      emit(CartLoaded(List.from(cartItems)));
    }
  }

  double get totalPrice {
    return cartItems.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }
}