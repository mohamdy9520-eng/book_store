import 'package:book_store/features/reset_password/cubit/reset_password_cubit.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Update Password',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),

                      Center(
                        child: Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: FontFamily.merriweather,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      SizedBox(height: 60.h),

                      _PasswordField(
                        controller: currentPasswordController,
                        hint: 'Current Password',
                      ),

                      SizedBox(height: 20.h),

                      _PasswordField(
                        controller: newPasswordController,
                        hint: 'New Password',
                      ),

                      SizedBox(height: 20.h),

                      _PasswordField(
                        controller: confirmPasswordController,
                        hint: 'Confirm Password',
                        isConfirm: true,
                      ),

                      SizedBox(height: 60.h),

                      _UpdateButton(
                        currentPasswordController: currentPasswordController,
                        newPasswordController: newPasswordController,
                        confirmPasswordController: confirmPasswordController,
                      ),

                      SizedBox(height: 20.h),
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

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isConfirm;

  const _PasswordField({
    required this.controller,
    required this.hint,
    this.isConfirm = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) => current is PasswordVisibilityChanged,
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        return TextField(
          controller: controller,
          obscureText: !cubit.isPasswordVisible,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontFamily: FontFamily.nunito,
            ),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),
            suffixIcon: isConfirm
                ? IconButton(
              icon: Icon(
                cubit.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: cubit.togglePasswordVisibility,
            )
                : null,
          ),
        );
      },
    );
  }
}

class _UpdateButton extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const _UpdateButton({
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );

          currentPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
        }

        if (state is ResetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        if (state is ResetPasswordLoading) {
          return SizedBox(
            width: double.infinity,
            height: 56.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffBFA054),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              cubit.updatePassword(
                currentPassword: currentPasswordController.text,
                newPassword: newPasswordController.text,
                confirmPassword: confirmPasswordController.text,
              );
            },
            child: Text(
              'Update Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.dm,
              ),
            ),
          ),
        );
      },
    );
  }
}