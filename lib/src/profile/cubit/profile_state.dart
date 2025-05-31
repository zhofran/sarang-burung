part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileOnLoading extends ProfileState {}

final class ProfileAssignReferralOnSuccess extends ProfileState {}

final class ProfileOnSuccess extends ProfileState {
  const ProfileOnSuccess({required this.model});
  final UserModel model;

  @override
  List<Object> get props => [model];
}

final class ProfileOnFailed extends ProfileState {
  const ProfileOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

final class ProfileOnError extends ProfileState {
  const ProfileOnError({required this.model});
  final AppReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
