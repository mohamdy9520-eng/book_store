part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeSuccessState extends HomeState {
  final List<SliderItem>? sliders;
  HomeSuccessState({this.sliders});

}

final class HomeErrorState  extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class BestSellerErrorState extends HomeState {}
final class BestSellerSuccessState extends HomeState {

  final List<Product>? products;

  BestSellerSuccessState(this.products);
}
final class BestSellerLoadingState extends HomeState {}

final class AddToCartSuccessState extends HomeState {}
final class AddToCartLoadingState extends HomeState {}
final class AddToCartErrorState extends HomeState {}
