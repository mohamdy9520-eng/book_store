import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/features/cart/cubit/cart_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final int index;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.name+index.toString()),
      direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          context.read<CartCubit>().removeFromCartById(item.id);
          return true;
        },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
      
            Row(
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
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "₹${item.price.toStringAsFixed(0)}",
                        style: TextStyle(
                          color: Colors.grey[600],
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
                                    index,
                                    item.quantity - 1,
                                  );
                                }
                              },
                              child: const SizedBox(
                                width: 36,
                                height: 36,
                                child: Icon(Icons.remove, size: 18),
                              ),
                            ),
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text(item.quantity.toString()),
                            ),
                            InkWell(
                              onTap: () {
                                context.read<CartCubit>().updateQuantity(
                                  index,
                                  item.quantity + 1,
                                );
                              },
                              child: const SizedBox(
                                width: 36,
                                height: 36,
                                child: Icon(Icons.add, size: 18),
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
      
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  context.read<CartCubit>().removeFromCartById(item.id);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}