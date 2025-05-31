part of 'visibility_cubit.dart';

sealed class VisibilityState extends Equatable {
  const VisibilityState();

  @override
  List<Object> get props => [];
}

final class VisibilityInitial extends VisibilityState {}

final class VisibilityLoading extends VisibilityState {}

final class VisibilitySuccess extends VisibilityState {}

