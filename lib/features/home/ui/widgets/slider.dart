

import 'package:book_store/core/widgets/custom_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/home_cubit.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:(prev,current)=>current is HomeLoadingState|| current is HomeErrorState|| current is HomeSuccessState,
      builder: (context, state) {
        if(state is HomeLoadingState){
          return Skeletonizer(
            enabled: true,
            child: Container(
              height: 150.h,
              width: double.infinity,
              color: Colors.grey,
            ),
          );
        } else if (state is HomeSuccessState){
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 150.0.h,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, r) {
                      setState(() {
                        activeIndex = index;
                      });
                    }

                ),
                items: state.sliders?.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CustomNetworkImage(imageUrl:i.image??"" ,
                        width: double.infinity,)


                        );
                    },
                  );
                }).toList(),
              ),
              Gap(14.h),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 7.h,
                ),
              )
            ],
          );
        }else{
          return Text("error");
        }
      },
    );
  }
}
