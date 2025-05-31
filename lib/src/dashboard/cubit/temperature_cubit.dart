// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/sensor_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'temperature_state.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit() : super(TemperatureInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(TemperatureLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response temperaturesResponse = await AppApi.get(
        path: '/v1/sensor/temperature',
        param: {
          'site_id': prefs.getString('siteId'),
          'cage_id': selectedCageId,
        },
      );

      var model = SensorModel.fromJson(temperaturesResponse.data['data']);

      emit(TemperatureLoaded(model: model));
    } catch (e) {
      emit(TemperatureError(message:
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
