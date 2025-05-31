part of 'amonia_cubit.dart';

@immutable
abstract class AmoniaState {}

class AmoniaInitial extends AmoniaState {}

class AmoniaLoading extends AmoniaState {}

class AmoniaLoaded extends AmoniaState {
  final SensorModel model;

 AmoniaLoaded({required this.model});
}

class AmoniaError extends AmoniaState {
  final String message;
   AmoniaError({required this.message});
}
