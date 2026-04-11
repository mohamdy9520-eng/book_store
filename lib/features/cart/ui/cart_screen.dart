import 'package:book_store/features/home/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/features/cart/cubit/cart_cubit.dart';

import '../../../core/theme/app_text_style.dart';
import '../model/cart_model.dart';
import 'cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "My Cart",
          style: AppTextStyle.headline,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(child: Text(state.message));
          }

          if (state is CartLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const Center(child: Text("Cart is empty"));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return CartItemWidget(item: item);
                    },
                  )
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: AppTextStyle.headline?.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "\$ 95.00",
                              style: AppTextStyle.Price?.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Checkout logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC4A35A), // ⬅️ اللون الذهبي
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Checkout",
                              style: AppTextStyle.Button.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("Cart is ready"));
        },
      ),
    );
  }
}