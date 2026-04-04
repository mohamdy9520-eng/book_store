import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/model_slider.dart';
import '../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getSlider()async{
    emit(HomeLoadingState());
    final response=await HomeRepo.getSlider();
    if(response!=null){
      emit(HomeSuccessState(sliders: response.data?.sliders??[]));
    }else{
      emit(HomeErrorState());
    }
  }




}
