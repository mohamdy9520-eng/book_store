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
        padding:  EdgeInsets.only(bottom: 20.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    item.imageUrl,
                    width: 80.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80.w,
                        height: 100.h,
                        color: Colors.grey[300],
                        child: const Icon(Icons.book, color: Colors.grey),
      
                      );
                    },
                  ),
                ),
      
                 SizedBox(width: 16.w),
      
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                       SizedBox(height: 6.h),
                      Text(
                        "₹${item.price.toStringAsFixed(0)}",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                       SizedBox(height: 16.h),
      
                      Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
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
                              child: SizedBox(
                                width: 36.w,
                                height: 36.h,
                                child: Icon(Icons.remove, size: 18),
                              ),
                            ),
                            Container(
                              width: 40.w,
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
                              child: SizedBox(
                                width: 36.w,
                                height: 36.h,
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
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.w),
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