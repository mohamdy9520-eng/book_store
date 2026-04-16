import 'package:book_store/features/home/ui/widgets/home_app_bar.dart';
import 'package:book_store/features/home/ui/widgets/product_item.dart';
import 'package:book_store/features/home/ui/widgets/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_text_style.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (prev, current) =>
          current is BestSellerSuccessState ||
              current is HomeLoadingState ||
              current is BestSellerErrorState,
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                HomeAppBar(),

                SizedBox(height: 25.h),

                SizedBox(
                  height: 180.h,
                  child: HomeSlider(),
                ),

                SizedBox(height: 31.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text("Best Seller",
                      style: AppTextStyle.headline),
                ),

                SizedBox(height: 10.h),

                if (state is HomeLoadingState)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11.w,
                      mainAxisSpacing: 11.h,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        backgroundColor: Colors.grey.shade300,
                      );
                    },
                  )
                else if (state is BestSellerSuccessState)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11.w,
                      mainAxisSpacing: 11.h,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: state.products?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        product: state.products![index],
                      );
                    },
                  )
                else
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Error"),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}