import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  void submit({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }){
    RegExp passwordRegex=RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$'
    );
    if(userName.isEmpty){
      emit(SignupErrorState("UserName cannot be empty"));
    }else if(password.isEmpty || confirmPassword.isEmpty){
      emit(SignupErrorState("Password fields cannot be empty"));
    }else  if(!passwordRegex.hasMatch(password)){
      emit(SignupErrorState("Password must contain: A, a, 1, @ and be at least 8 characters"));
    }else if(password !=confirmPassword){
      emit(SignupErrorState("Password don't match"));
    }else{
      emit(SignupLoadingState());

      Future.delayed(const Duration(seconds: 2),
              (){emit(SignupSuccessState());
      });
    }
    }

  }


