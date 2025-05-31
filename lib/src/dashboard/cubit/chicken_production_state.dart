part of 'chicken_production_cubit.dart';

@immutable
abstract class ChickenProductionState {}

class ChickenProductionInitial extends ChickenProductionState {}

class ChickenProductionLoading extends ChickenProductionState {}

class ChickenProductionLoaded extends ChickenProductionState {
  final List<ChickenProductionModel> models;
  final ChickenProductionSummary summary;

 ChickenProductionLoaded({required this.models, required this.summary});
}

class ChickenProductionError extends ChickenProductionState {
  final String message;
   ChickenProductionError({required this.message});
}
