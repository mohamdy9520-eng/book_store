import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/theme/product_TextStyle.dart';
import 'package:book_store/core/widgets/buy_button.dart';
import 'package:book_store/core/widgets/custom_network_image.dart';
import 'package:book_store/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/model/cart_model.dart';
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CustomNetworkImage(
                      imageUrl: product?.image ?? "",
                      height: 173.38.h,
                      width: 140.9.w,
                    ),
                  ),


                ],
              ),

              SizedBox(height: 5.67.h),

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

              SizedBox(height: 24.73.h),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      product?.price ?? "",
                      style: ProductTextstyle.price,
                    ),
                  ),

                  SizedBox(width: 10.w),

        InkWell(
          child: BuyButton(
            text: "Buy",
            onTap: () {
              if (product == null) return;
              context.read<CartCubit>().addToCart(
                CartItem(
                  id: product!.id.toString(),
                  name: product!.name ?? "",
                  price: double.tryParse(product!.price ?? "0") ?? 0,
                  imageUrl: product!.image ?? "",
                  quantity: 1,
                ),
              );
            },
          ),
        )
                ]
                  ),
                ],
              ),
          ),
        ),
      );
  }
}