// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:report_sarang/src/dashboard/models/location_model.dart';

part 'location_batch_state.dart';

class LocationBatchCubit extends Cubit<LocationBatchState> {
  LocationBatchCubit() : super(LocationBatchInitial());

  Future<void> fetchLocationBatchData() async {
    try {
      emit(LocationBatchLoading());

      // Simulasi pengambilan data dari database
      await Future.delayed(Duration(seconds: 2));
      // final locations = [
      //   LocationModel(id: '1', name: 'Majalengka'),
      //   LocationModel(id: '2', name: 'Bandung'),
      //   LocationModel(id: '3', name: 'Jakarta'),
      // ];

      // emit(LocationBatchLoaded(locations: locations, batches: batches));
    } catch (e) {
      emit(LocationBatchError(message: 'Failed to load data'));
    }
  }
}
