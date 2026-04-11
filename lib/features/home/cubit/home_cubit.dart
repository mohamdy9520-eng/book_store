import 'package:bloc/bloc.dart';
import 'package:book_store/features/cart/data/repo/cart_repo.dart';
import 'package:book_store/features/home/data/models/best_seller_response.dart';
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
  Future<void> getBestSeller()async{
    emit(HomeLoadingState());
    final response=await HomeRepo.getBestSeller();
    if(response !=null){
      emit(BestSellerSuccessState(response.data?.products??[]));
    }else{
      emit(BestSellerErrorState());

    }
  }

  Future<void> addToCart(int productId)async{
    emit(AddToCartLoadingState());
    final response=await CartRepo.addToCart(productId);
    if(response){
      emit(AddToCartSuccessState());
    }else{
      emit(AddToCartErrorState());
    }
  }




}
