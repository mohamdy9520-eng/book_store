import 'dart:ui';
import 'package:book_store/features/book_details/ui/book_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/product_TextStyle.dart';
import '../../../../core/widgets/buy_button.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/model/cart_model.dart';
import '../../cubit/home_cubit.dart';
import '../../data/models/best_seller_response.dart';

class ProductItem extends StatelessWidget {
  final Product? product;
  final Color? backgroundColor;

  const ProductItem({super.key, this.product, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddToCartLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AddToCartSuccessState) {
          Navigator.pop(context);

          final messenger = ScaffoldMessenger.of(context);
          messenger.hideCurrentSnackBar();

          messenger.showSnackBar(
            const SnackBar(
              content: Text("Successfully Added"),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          if (product == null) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookDetailsBody(
                book: product!,
              ),
            ),
          );
        },
        child: SizedBox(
          width: 163.w,
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: backgroundColor ?? AppColors.productBackGroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomNetworkImage(
                    imageUrl: product?.image ?? "",
                    height: 173.38.h,
                    width: 140.9.w,
                  ),
                ),

                SizedBox(height: 6.h),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product?.name ?? "",
                        style: ProductTextstyle.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product?.price ?? "",
                        style: ProductTextstyle.price,
                      ),
                    ),

                    SizedBox(width: 10.w),

                    SizedBox(
                      child: BuyButton(
                        text: "Buy",
                        onTap: () {
                          if (product == null) return;
                      
                          context.read<CartCubit>().addToCart(
                            CartItem(
                              id: product!.id ?? 0,
                              name: product!.name ?? "",
                              price: double.tryParse(product!.price ?? "0") ?? 0,
                              imageUrl: product!.image ?? "",
                              quantity: 1,
                              product: product!.name ?? "",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}