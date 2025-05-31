part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashSuccess extends SplashState{}

final class SplashSuccessLocation extends SplashState {}

final class SplashFailed extends SplashState {
  const SplashFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class SplashError extends SplashState {
  const SplashError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
