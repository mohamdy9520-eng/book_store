import 'package:book_store/features/edit%20profile/cubit/edit_profile_cubit.dart';
import 'package:book_store/features/edit%20profile/ui/edit_profile.dart';
import 'package:book_store/features/profile/widget/profile_item.dart';
import 'package:book_store/features/reset_Password/ui/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => EditProfileCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.read<ProfileCubit>().logout();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return const Center(child: Text("Something went wrong"));
            }

            if (state is ProfileLoaded) {
              final user = state.user;

              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BlocBuilder<EditProfileCubit, EditProfileState>(
                          builder: (context, state) {
                            final cubit =
                            context.watch<EditProfileCubit>();

                            return CircleAvatar(
                              radius: 35.r,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: cubit.selectedImage != null ? FileImage(cubit.selectedImage!) : null,
                              child: cubit.selectedImage == null ? Icon(Icons.person, size: 30.sp) : null,
                            );
                          },
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25.h),
                    ProfileItem(title: "My Orders", onTap: () {}),
                    ProfileItem(
                      title: "Edit Profile",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileItem(title:"Reset Password", onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder:
                      (context)=>ResetPasswordScreen()));
                    }),
                    buildItem("FAQ"),
                    buildItem("Contact Us"),
                    buildItem("Privacy & Terms"),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildItem(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}