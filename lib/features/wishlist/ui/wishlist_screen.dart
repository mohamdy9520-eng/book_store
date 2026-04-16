import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:book_store/features/wishlist/cubit/wishlist_state.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("WishList", style:TextStyle(fontSize: 30.sp,
       fontWeight: FontWeight.w400, fontFamily: FontFamily.dm)),
       centerTitle: true,
     ),
     body: BlocBuilder<WishlistCubit, WishlistState>(
         builder: (context, state) {
           if (state is WishlistLoaded) {
             final items = state.items;

             if(items.isEmpty){
               return Center(
                 child:Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                   Lottie.network("https://lottie.host/16347347-c5cd-47a3-a2bc-0a9b7d79bf07/d6iMArZ1JH.json",
                   width: 300.w,
                   repeat: true
                   ),
                     SizedBox(height: 20.h),

                     Text("No Items Here",
                       style: AppTextStyle.hintStyle.copyWith(fontSize: 24.sp),)
                   ],
                 ),
               );
             }

             return GridView.builder(
               padding: EdgeInsets.all(16.w),
               itemCount: items.length,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 12.w,
                 mainAxisSpacing: 12.h,
                 childAspectRatio: 0.55,
               ),
               itemBuilder: (context, index) {
                 final item = items[index];

                 return Container(
                   padding: EdgeInsets.all(10.w),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(12.r),
                     border: Border.all(color: Colors.grey.shade300),
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(8.r),
                           child: Image.network(
                             item.image,
                             width: double.infinity,
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),

                       SizedBox(height: 6.h),


                       Text(
                         item.name,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 13.sp,
                         ),
                       ),

                       SizedBox(height: 4.h),


                       Row(
                         children: [
                           Expanded(
                             child: Text(
                               "₹${item.price}",
                               style: TextStyle(
                                 color: Colors.green,
                                 fontSize: 13.sp,
                               ),
                             ),
                           ),

                           GestureDetector(
                             onTap: () {
                               context.read<WishlistCubit>().remove(item.id);
                             },
                             child: Icon(
                               Icons.delete,
                               color: Colors.red,
                               size: 20.sp,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 );;
               },
             );
           }
           return const Center(child: CircularProgressIndicator());

         },
     ),
   );
  }


}