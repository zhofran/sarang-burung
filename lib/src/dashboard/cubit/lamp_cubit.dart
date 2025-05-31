// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/sensor_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'lamp_state.dart';

class LampCubit extends Cubit<LampState> {
  LampCubit() : super(LampInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(LampLoading());

      Response lampResponse = await AppApi.get(
        path: '/v1/sensor/ldr',
        param: {
          ...(selectedCageId != null ? {'cageId': selectedCageId} : {}),
        },
      );

      log('lampResponse: ${lampResponse.data}');

      var models = (lampResponse.data['data'] as List? ?? [])
          .map((e) => Sensor.fromJson(e))
          .toList();

      emit(LampLoaded(models: models));
    } catch (e) {
      emit(LampError(message:
      'Failed to load data ${e.toString()}'));
    }
  }

void updateSelectedCage(String? cageId) {
    log('updateSelectedCage: $cageId');
    if(selectedCageId != cageId) {
      selectedCageId = cageId;
      go();
    }
  }
}
