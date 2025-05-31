// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/cctv_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'cctv_state.dart';

class CCTVCubit extends Cubit<CCTVState> {
  CCTVCubit() : super(CCTVInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(CCTVLoading());

      Response cctvResponse = await AppApi.get(
        path: '/v1/cctv/${
            selectedCageId ?? '0'
        }/cage'
      );

      var models = (cctvResponse.data['data'] as List? ?? [])
          .map((e) => CctvModel.fromJson(e))
          .toList();

      emit(CCTVLoaded(models: models));
    } catch (e) {
      emit(CCTVError(message:
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
