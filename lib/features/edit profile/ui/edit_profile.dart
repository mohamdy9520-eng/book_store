import 'dart:io';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/edit_profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Edit Profile"),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      _ProfileImage(
                        onTap: () => _showImageSource(context),
                      ),

                      SizedBox(height: 30.h),

                      _buildField("Full Name", nameController),
                      _buildField("Phone", phoneController),
                      _buildField("Address", addressController),

                      SizedBox(height: 40.h),

                      _UpdateButton(
                        nameController: nameController,
                        phoneController: phoneController,
                        addressController: addressController,
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

  void _showImageSource(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  context.read<EditProfileCubit>()
                      .pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  context.read<EditProfileCubit>()
                      .pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildField(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final VoidCallback onTap;

  const _ProfileImage({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        File? image;

        if (state is ImagePickedState) {
          image = state.image;
        }

        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            InkWell(
              onTap: onTap,
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: image != null ? FileImage(image) : null,
                child: image == null
                    ? Icon(Icons.person, size: 40.sp)
                    : null,
              ),
            ),
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_alt, size: 18.sp),
            ),
          ],
        );
      },
    );
  }
}

class _UpdateButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  const _UpdateButton({
    required this.nameController,
    required this.phoneController,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is EditProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is EditProfileLoading) {
          return SizedBox(
            width: double.infinity,
            height: 55.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: 55.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffBFA054),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              context.read<EditProfileCubit>().updateProfile(
                name: nameController.text,
                phone: phoneController.text,
                address: addressController.text,
              );
            },
            child: Text(
              "Update Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.dm,
              ),
            ),
          ),
        );
      },
    );
  }
}