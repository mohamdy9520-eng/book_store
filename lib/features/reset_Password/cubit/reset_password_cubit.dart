import 'package:bloc/bloc.dart';
import 'package:book_store/core/networking/dio.helper.dart';
import 'package:dio/dio.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());

    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(ResetPasswordError('All fields are required'));
      return;
    }

    if (newPassword.length < 6) {
      emit(ResetPasswordError('Password must be at least 6 characters'));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(ResetPasswordError('Passwords do not match'));
      return;
    }

    try {
      final response = await DioHelper.dio!.post(
        "update-password",
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirmation": confirmPassword,
        },
      );

      emit(ResetPasswordSuccess('Password updated successfully'));

    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        String message = 'Validation Error';

        if (errors != null) {
          if (errors['current_password'] != null) {
            message = errors['current_password'][0];
          } else if (errors['new_password'] != null) {
            message = errors['new_password'][0];
          }
        }

        emit(ResetPasswordError(message));
      } else if (e.response?.statusCode == 401) {
        emit(ResetPasswordError('Current password is incorrect'));
      } else {
        emit(ResetPasswordError(e.message ?? 'Network error'));
      }
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }
}