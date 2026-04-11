import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:book_store/features/search_screen/repo/search_repo.dart';
import '../../home/data/models/best_seller_response.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {
    _init();
  }

  final BehaviorSubject<String> _searchSubject =
  BehaviorSubject<String>.seeded("");

  StreamSubscription? _subscription;

  void onSearchChanged(String query) {
    _searchSubject.add(query.trim());
  }

  void _init() {
    _subscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((query) {
      if (query.isEmpty) {
        _getAllProducts();
      } else {
        _performSearch(query);
      }
    });
  }

  Future<void> _performSearch(String query) async {
    try {
      emit(SearchLoadingState());

      final response = await SearchRepo.search(text: query);

      final products = response?.data?.products ?? [];

      emit(SearchSuccessState(products));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  Future<void> _getAllProducts() async {
    try {
      emit(SearchLoadingState());

      final response = await SearchRepo.search(text: "");

      final products = response?.data?.products ?? [];

      emit(SearchSuccessState(products));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await _searchSubject.close();
    return super.close();
  }
}