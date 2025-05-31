part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginSuccessSite extends LoginState {
  const LoginSuccessSite({
    required this.dataLogin,
  });

  final LoginModel dataLogin;

  @override
  List<Object> get props => [dataLogin];
}

final class LoginFailed extends LoginState {
  const LoginFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class LoginError extends LoginState {
  const LoginError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
