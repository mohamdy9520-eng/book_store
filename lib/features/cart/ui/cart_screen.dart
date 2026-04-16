import 'package:book_store/features/cart/cubit/cart_cubit.dart';
import 'package:book_store/features/cart/model/cart_model.dart';
import 'package:book_store/features/place_yourOrder/ui/place_your_order.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../data/lottie/cached_lottie.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "My Cart",
            style: TextStyle(
              fontFamily: FontFamily.dm,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              final items = state.items;

              final total = items.fold<double>(
                0,
                    (sum, item) =>
                sum + (item.price.toDouble() * item.quantity),
              );

              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 200.w,
                        height: 200.h,
                        child: CachedLottie(url: "https://lottie.host/498504e4-1bd0-4c4c-aa31-6a2548aa1a7e/sdB7sHX5nf.json",
                        width: 200.w,
                        height: 200.w)
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Your cart is empty!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Dismissible(
                            key: ValueKey(item.id),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            context.read<CartCubit>().removeFromCartById(item.id);
                            return true;
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.imageUrl,
                                      width: 70.w,
                                      height: 70.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image_not_supported);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12.w),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: TextStyle(fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        SizedBox(height: 6.h),

                                        Text(
                                          "\$${item.price}",
                                          style: TextStyle(fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            context
                                                .read<CartCubit>()
                                                .updateQuantity(
                                              item.id,
                                              item.quantity - 1,
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text("${item.quantity}"),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .updateQuantity(
                                            item.id,
                                            item.quantity + 1,
                                          );
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: GoogleFonts.nunitoSans(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff808080),
                              ),
                            ),
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff303030),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        SizedBox(
                          width: double.infinity,
                          height: 55.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffBFA054),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlaceYourOrder(),
                                  ),
                                );
                              },
                              child: Text(
                                "Checkout",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}