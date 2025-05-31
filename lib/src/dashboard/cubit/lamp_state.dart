part of 'lamp_cubit.dart';

@immutable
abstract class LampState {}

class LampInitial extends LampState {}

class LampLoading extends LampState {}

class LampLoaded extends LampState {
  final List<Sensor> models;

 LampLoaded({required this.models});
}

class LampError extends LampState {
  final String message;
   LampError({required this.message});
}
