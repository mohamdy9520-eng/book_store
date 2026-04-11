import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/features/cart/cubit/cart_cubit.dart';

import '../model/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: 80,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.book, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 16),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<CartCubit>().removeFromCart(item.name);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),


                Text(
                  "₹${item.price.toStringAsFixed(0)}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),


                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      InkWell(
                        onTap: () {
                          if (item.quantity > 1) {
                            context.read<CartCubit>().updateQuantity(
                              item.name,
                              item.quantity - 1,
                            );
                          }
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ),


                      Container(
                        width: 40,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            vertical: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        child: Text(
                          item.quantity.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),


                      InkWell(
                        onTap: () {
                          context.read<CartCubit>().updateQuantity(
                            item.name,
                            item.quantity + 1,
                          );
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}