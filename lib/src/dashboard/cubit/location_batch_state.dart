part of 'location_batch_cubit.dart';

@immutable
abstract class LocationBatchState {}

class LocationBatchInitial extends LocationBatchState {}

class LocationBatchLoading extends LocationBatchState {}

class LocationBatchLoaded extends LocationBatchState {
  final List<LocationModel> locations;
  // final List<Batch> batches;

  LocationBatchLoaded({required this.locations});
}

class LocationBatchError extends LocationBatchState {
  final String message;

  LocationBatchError({required this.message});
}
