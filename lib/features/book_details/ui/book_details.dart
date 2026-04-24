import 'package:book_store/core/widgets/buy_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../cart/model/cart_model.dart';
import '../../home/data/models/best_seller_response.dart';
import '../../wishlist/cubit/wishlist_cubit.dart';
import '../../wishlist/cubit/wishlist_state.dart';

class BookDetailsBody extends StatelessWidget {
  final Product book;

  const BookDetailsBody({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.pop(context),
                  ),
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      final isFav =
                      context.read<WishlistCubit>().isFav(book.id ?? 0);

                      return GestureDetector(
                        onTap: () {
                          context.read<WishlistCubit>().toggle(book);
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.black,
                        ),
                      );
                    },
                  )
                ],
              ),

               SizedBox(height: 30.h),

              Container(
                height: 271.h,
                width: 183.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  image: DecorationImage(
                    image: NetworkImage(book.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 11.h),

              Text(
                book.name ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 5.h),

              Text(
                book.category?.toString() ?? "",
                style: const TextStyle(color: Colors.orange),
              ),

              SizedBox(height: 21.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    (book.description ?? "").replaceAll(RegExp(r'<[^>]*>'), ''),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 52.h),

              Row(
                children: [
                  Text(
                    "₹${book.price}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),

                  BuyButton(
                    width: 212.w,
                    height: 56.h,
                    text: "Add to Cart",
                    onTap: () {
                      context.read<CartCubit>().addToCart(
                        CartItem(
                          id: book.id ?? 0,
                          name: book.name ?? "",
                          price: double.tryParse(book.price ?? "0") ?? 0,
                          imageUrl: book.image ?? "",
                          quantity: 1,
                          product: book.name ?? "",
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Container(
      height: 45.h,
      width: 45.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18.sp),
        onPressed: onTap,
      ),
    );
  }
}