part of 'log_sensor_cubit.dart';

@immutable
abstract class LogSensorState {}

class LogSensorInitial extends LogSensorState {}

class LogSensorLoading extends LogSensorState {}

class LogSensorLoaded extends LogSensorState {
  final List<LogSensorModel> models;

 LogSensorLoaded({required this.models});
}

class LogSensorError extends LogSensorState {
  final String message;
   LogSensorError({required this.message});
}
