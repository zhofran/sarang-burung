// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/sensor_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'amonia_state.dart';

class AmoniaCubit extends Cubit<AmoniaState> {
  AmoniaCubit() : super(AmoniaInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(AmoniaLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response amoniasResponse = await AppApi.get(
        path: '/v1/sensor/amonia',
        param: {
          'site_id': prefs.getString('siteId'),
          'cage_id': selectedCageId,
        },
      );

      var model = SensorModel.fromJson(amoniasResponse.data['data']);

      emit(AmoniaLoaded(model: model));
    } catch (e) {
      emit(AmoniaError(message:
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
