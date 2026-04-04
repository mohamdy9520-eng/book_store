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
