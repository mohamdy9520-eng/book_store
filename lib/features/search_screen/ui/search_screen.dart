import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/core/widgets/custome_TextForm.dart';
import 'package:book_store/features/search_screen/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../home/ui/widgets/product_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child:Padding(
          padding:EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomTextFormField(hintText: "Search",
            onChanged: (v){
              context.read<SearchCubit>().onSearchChanged(v);
            }
              ),

            SizedBox(height: 20.h),

            BlocBuilder<SearchCubit,SearchState>(
                builder:(context,state) {
                  if (state is SearchLoadingState) {
                    return Expanded(
                      child: Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 11.w,
                                mainAxisSpacing: 11.h,
                                childAspectRatio: 0.55),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return ProductItem(
                                backgroundColor: Colors.grey.shade300,
                              );
                            }),
                      ),
                    );
                  }
                  else if (state is SearchSuccessState) {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 11.w,
                              mainAxisSpacing: 11.h,
                              childAspectRatio: 0.55),
                          itemCount: state.products?.length,
                          itemBuilder: (context, index) {
                            return ProductItem(
                                product: state.products?[index]
                            );
                          }),
                    );
                  } else {
                    return Text("What are you looking for?!");
                  }
                })
          ],
        ),
      )
      )
          );
  }
}
