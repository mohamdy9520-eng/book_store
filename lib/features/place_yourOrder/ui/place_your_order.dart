import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/core/widgets/custome_TextForm.dart';
import 'package:book_store/features/order_success/ui/order_success.dart';
import 'package:book_store/features/place_yourOrder/cubit/place_your_order_cubit.dart';
import 'package:book_store/features/place_yourOrder/cubit/place_your_order_state.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/networking/dio.helper.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../governorate/cubit/govornorate_cubit.dart';
import '../governorate/cubit/govornorate_state.dart';
import '../governorate/model/api_servuce.dart';

class PlaceYourOrder extends StatelessWidget {
  const PlaceYourOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlaceOrderCubit(),
        ),
        BlocProvider(
          create: (_) => GovCubit(ApiService())..getGovernorates(),
        ),
      ],
      child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) {
          if (state is PlaceOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Order Placed Successfully")),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const OrderSuccess(),
              ),
            );
          }

          if (state is PlaceOrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<PlaceOrderCubit>();
          final govState = context.watch<GovCubit>().state;
          final total = context.watch<CartCubit>().totalPrice;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: const BackButton(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Place Your Order",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Don't worry! It occurs. Please enter the email address linked with your account.",
                        style: AppTextStyle.hintStyle,
                      ),
                      SizedBox(height: 25.h),
                      CustomTextFormField(
                        controller: cubit.nameController,
                        hintText: "Full Name",
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: cubit.emailController,
                        hintText: "Email",
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: cubit.addressController,
                        hintText: "Address",
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: cubit.phoneController,
                        hintText: "Phone",
                      ),
                      SizedBox(height: 12.h),
                      DropdownButtonFormField<String>(
                        value: cubit.governorate,
                        hint: Text(
                          "Select Governorate",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                            BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                            const BorderSide(color: Colors.blue),
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: (govState is GovSuccess)
                            ? govState.governorates.map((gov) {
                          return DropdownMenuItem<String>(
                            value: gov.governorateNameEn,
                            child: Text(gov.governorateNameEn),
                          );
                        }).toList() : [],
                        onChanged: (value) {
                          if (value != null) {
                            cubit.changeGovernorate(value);
                          }
                        },
                      ),
                      SizedBox(height: 123.h),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamily.nunito,
                            ),
                          ),
                          Text(
                            "$total EGP",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      InkWell(
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.placeOrder(total: total);
                          }
                        },
                        child: Container(
                          width: 331.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: const Color(0xffBFA054),
                          ),
                          child: Center(
                            child: Text(
                              "Submit Order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.dm,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}