import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:book_store/features/home/ui/home_screen.dart';
import 'package:book_store/features/order_success/cubit/order_success_cubit.dart';
import 'package:book_store/features/order_success/cubit/order_success_state.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSuccess extends StatelessWidget{
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderSuccessCubit()..getOrderSuccess(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<OrderSuccessCubit, OrderSuccessState>(
            builder: (context, state) {

              if (state is OrderSuccessLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is OrderSuccessSuccess) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 145.w,
                        height: 145.h,
                        decoration: const BoxDecoration(
                          color: Color(0xff18C07A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      SizedBox(height: 49.h),

                      Text(
                        "SUCCESS",
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.merriweather,
                        ),
                      ),

                      SizedBox(height: 22.h),

                      Text(
                        "Your order will be delivered soon."
                            "Thank you for choosing our app!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.nunito,
                          color: Color(0xff606060),
                        ),
                      ),

                      SizedBox(height: 51.h),

                      SizedBox(
                        width: 331.w,
                        height: 56.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffBFA054),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onPressed: ()async {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:(context)=>HomeScreen())
                            );
                          },
                          child: Text(
                            "Back To Home",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.dm,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is OrderSuccessError) {
                return Center(child: Text(state.error));
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}