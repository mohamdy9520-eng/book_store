import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_servuce.dart';
import '../model/gov_nerate.dart';
import 'govornorate_state.dart';

class GovCubit extends Cubit<GovState> {
  final ApiService api;

  GovCubit(this.api) : super(GovInitial());

  Governorate? selectedGovernorate;

  Future<void> changeGovernorate(Governorate gov) async {
    selectedGovernorate = gov;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("gov", gov.governorateNameEn);

    if (state is GovSuccess) {
      emit(GovSuccess((state as GovSuccess).governorates));
    }
  }

  Future<void> getGovernorates() async {
    emit(GovLoading());

    try {
      final data = await api.getGovernorates();

      emit(GovSuccess(data));
    } catch (e) {
      emit(GovError(e.toString()));
    }
  }
}