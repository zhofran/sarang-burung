// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/sensor_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'humidity_state.dart';

class HumidityCubit extends Cubit<HumidityState> {
  HumidityCubit() : super(HumidityInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(HumidityLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response humiditysResponse = await AppApi.get(
        path: '/v1/sensor/humidity',
        param: {
          'site_id': prefs.getString('siteId'),
          'cage_id': selectedCageId,
        },
      );

      log('humiditysResponse: ${humiditysResponse.data['data']}');

      var model = SensorModel.fromJson(humiditysResponse.data['data']);

      emit(HumidityLoaded(model: model));
    } catch (e) {
      emit(HumidityError(message:
      'Failed to load data ${e.toString()}'));
    }
  }

  void updateSelectedCage(String? cageId) {
    if(selectedCageId != cageId) {
      selectedCageId = cageId;
      go();
    }
  }
}
