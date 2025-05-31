part of 'humidity_cubit.dart';

@immutable
abstract class HumidityState {}

class HumidityInitial extends HumidityState {}

class HumidityLoading extends HumidityState {}

class HumidityLoaded extends HumidityState {
  final SensorModel model;

 HumidityLoaded({required this.model});
}

class HumidityError extends HumidityState {
  final String message;
   HumidityError({required this.message});
}
