// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/log_sensor_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'log_sensor_state.dart';

class LogSensorCubit extends Cubit<LogSensorState> {
  LogSensorCubit() : super(LogSensorInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(LogSensorLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();


      Response temperaturesResponse = await AppApi.get(
        path: '/v1/sensor/relay-log',
        param: {
          'cageId': selectedCageId,
          'siteId': prefs.getString('siteId'),
        },
      );

      var models = (temperaturesResponse.data['data']['data'] as List)
          .map((e) => LogSensorModel.fromJson(e))
          .toList();

      emit(LogSensorLoaded(models: models));
    } catch (e) {
      emit(LogSensorError(message:
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
