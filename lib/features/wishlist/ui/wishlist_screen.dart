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

             return ListView.builder(
               padding: EdgeInsets.all(16),
               itemCount: items.length,
               itemBuilder: (context,index){
                 final item=items[index];

                 return Container(
                   margin: const EdgeInsets.only(bottom: 12),
                   padding: const EdgeInsets.all(10),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(12.r),
                       border: Border.all(color: Colors.grey.shade300)
                   ),
                   child: Row(
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(8.r),
                         child: Image.network(item.image,
                         height: 80.h,
                         width: 60.w,
                         fit: BoxFit.cover
                         ),
                       ),

                       SizedBox(width: 12.w),

                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                             ),

                             SizedBox(height:6.h),

                             Text("₹${item.price}",
                               style:const TextStyle(
                                   color:Colors.green
                               ),
                             ),
                           ],
                         ),
                       ),
                       IconButton(
                         icon: const Icon(Icons.delete, color:Colors.red),
                         onPressed: (){
                           context.read<WishlistCubit>().remove(item.id);
                         },
                       )
                     ],
                   ),
                 );
               },
             );
           }
           return const Center(child: CircularProgressIndicator());

         },
     ),
   );
  }


}