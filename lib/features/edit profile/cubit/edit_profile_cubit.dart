import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial()) {
    _initDio();
    loadImage();
  }

  late final Dio dio;
  File? selectedImage;

  void _initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://codingarabic.online/api',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<File?> _compressImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) return null;

      final resized = img.copyResize(
        image,
        width: 800,
        height: 800,
      );

      final compressedBytes = img.encodeJpg(resized, quality: 70);

      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final compressedFile = File(targetPath);
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      print('Compression error: $e');
      return file;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(EditProfileLoading());

    try {
      final token = await _getToken();
      if (token == null) {
        emit(EditProfileError('Please login first'));
        return;
      }

      File? imageToUpload = selectedImage;

      if (imageToUpload != null) {
        final sizeInKB = await imageToUpload.length() / 1024;

        if (sizeInKB > 300) {
          imageToUpload = await _compressImage(imageToUpload);

          if (imageToUpload == null) {
            emit(EditProfileError('Failed to compress image'));
            return;
          }

          final newSize = await imageToUpload.length() / 1024;
          if (newSize > 300) {
            emit(EditProfileError('Image still too large after compression. Please pick smaller image.'));
            return;
          }
        }
      }

      final formData = FormData.fromMap({
        'name': name,
        'phone': phone,
        'address': address,
        if (imageToUpload != null)
          'image': await MultipartFile.fromFile(
            imageToUpload.path,
            filename: 'profile.jpg',
          ),
      });

      final response = await dio.post(
        '/update-profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(EditProfileSuccess("Profile Updated Successfully"));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        String errorMessage = '';

        if (errors != null) {
          if (errors['phone'] != null) {
            errorMessage += 'Phone already taken. ';
          }
          if (errors['image'] != null) {
            errorMessage += errors['image'][0] + ' ';
          }
          if (errors['name'] != null) {
            errorMessage += 'Invalid name. ';
          }
        }

        emit(EditProfileError(errorMessage.trim()));
      } else if (e.response?.statusCode == 401) {
        emit(EditProfileError('Unauthorized - Please login again'));
      } else {
        emit(EditProfileError(e.message ?? 'Network error'));
      }
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (picked != null) {
      File image = File(picked.path);

      final compressed = await _compressImage(image);
      if (compressed != null) {
        image = compressed;
      }

      selectedImage = image;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("profile_image", image.path);
      emit(ImagePickedState(image));
    }
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString("profile_image");

    if (path != null && File(path).existsSync()) {
      selectedImage = File(path);
      emit(ImagePickedState(selectedImage!));
    }
  }
}