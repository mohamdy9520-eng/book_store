import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/features/home/cubit/home_cubit.dart';
import 'package:book_store/features/home/ui/widgets/home_app_bar.dart';
import 'package:book_store/features/home/ui/widgets/product_item.dart';
import 'package:book_store/features/home/ui/widgets/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(),

            SizedBox(height: 25.h),

            HomeSlider(),

            SizedBox(height: 31.h),

            Text("Best Seller", style: AppTextStyle.headline),

            BlocBuilder<HomeCubit,HomeState>(
                buildWhen:(prev,current)=>current is BestSellerSuccessState|| current is HomeLoadingState|| current is BestSellerErrorState,
                builder:(context,state){
              if(state is HomeLoadingState){
                return Expanded(
                  child: Skeletonizer(
                    enabled: true,
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        crossAxisSpacing: 11.w,
                        mainAxisSpacing: 11.h,
                        childAspectRatio: 0.55),
                        itemCount:6,
                        itemBuilder: (context,index){
                          return ProductItem(
                            backgroundColor: Colors.grey.shade300,
                          );
                        }),
                  ),
                );
              }else if(state is BestSellerSuccessState){
                return Expanded(
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      crossAxisSpacing: 11.w,
                      mainAxisSpacing: 11.h,
                      childAspectRatio: 0.55),
                      itemCount: state.products?.length,
                      itemBuilder: (context,index){
                        return ProductItem(
                            product:state.products?[index]
                        );
                      }),
                );
              }else{
                return Text("Error");
              }
            }
            )
          ],
        
        ),
      ),
    );
  }
}
