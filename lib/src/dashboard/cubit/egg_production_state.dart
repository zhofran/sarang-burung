part of 'egg_production_cubit.dart';

@immutable
abstract class EggProductionState {}

class EggProductionInitial extends EggProductionState {}

class EggProductionLoading extends EggProductionState {}

class EggProductionLoaded extends EggProductionState {
  final List<EggProductionModel> models;
  final EggProductionSummary summary;

 EggProductionLoaded({required this.models, required this.summary});
}

class EggProductionError extends EggProductionState {
  final String message;
   EggProductionError({required this.message});
}
