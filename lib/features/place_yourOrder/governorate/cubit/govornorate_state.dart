import '../model/gov_nerate.dart';

abstract class GovState {}

class GovInitial extends GovState {}

class GovLoading extends GovState {}

class GovSuccess extends GovState {
  final List<Governorate> governorates;

  GovSuccess(this.governorates);
}

class GovError extends GovState {
  final String message;

  GovError(this.message);
}