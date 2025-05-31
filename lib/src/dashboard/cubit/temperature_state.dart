part of 'temperature_cubit.dart';

@immutable
abstract class TemperatureState {}

class TemperatureInitial extends TemperatureState {}

class TemperatureLoading extends TemperatureState {}

class TemperatureLoaded extends TemperatureState {
  final SensorModel model;

 TemperatureLoaded({required this.model});
}

class TemperatureError extends TemperatureState {
  final String message;
   TemperatureError({required this.message});
}
