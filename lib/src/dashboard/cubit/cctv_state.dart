part of 'cctv_cubit.dart';

@immutable
abstract class CCTVState {}

class CCTVInitial extends CCTVState {}

class CCTVLoading extends CCTVState {}

class CCTVLoaded extends CCTVState {
  final List<CctvModel> models;

 CCTVLoaded({required this.models});
}

class CCTVError extends CCTVState {
  final String message;
   CCTVError({required this.message});
}
