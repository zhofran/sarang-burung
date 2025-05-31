part of 'cage_cubit.dart';

@immutable
abstract class CageState {}

class CageInitial extends CageState {}

class CageLoading extends CageState {}

class CageLoaded extends CageState {
  final List<CageModel> cages;

 CageLoaded({required this.cages});
}

class CageError extends CageState {
  final String message;
   CageError({required this.message});
}
