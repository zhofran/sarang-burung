part of 'profile_edit_cubit.dart';

sealed class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object> get props => [];
}

final class ProfileEditInitial extends ProfileEditState {}

final class ProfileEditOnLoading extends ProfileEditState {}

final class ProfileEditOnSuccess extends ProfileEditState {
  // const ProfileEditOnSuccess({required this.model});
  // final UserModel model;

  // @override
  // List<Object> get props => [model];
}

final class ProfileEditOnFailed extends ProfileEditState {
  const ProfileEditOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class ProfileEditOnError extends ProfileEditState {
  const ProfileEditOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
