// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/egg_production_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'egg_production_state.dart';

class EggProductionCubit extends Cubit<EggProductionState> {
  EggProductionCubit() : super(EggProductionInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(EggProductionLoading());

      Response temperaturesResponse = await AppApi.get(
        path: '/v1/dashboard/chart-egg',
        param: {
          'cage_id': selectedCageId,
          'groupBy': 'days',
          'startDate': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
          'endDate': DateTime.now().toIso8601String(),
        },
      );

      log('temperaturesResponse: ${temperaturesResponse.data['data']}');

      var models = (temperaturesResponse.data['data'] as List)
          .map((e) => EggProductionModel.fromJson(e))
          .toList();

      var sumHarga = 0;
      var sumBiaya  = 0;
      var sumTotal  = 0;
      var sumWeight = 0;

      for (var model in models) {
        sumHarga += model.totalHarga;
        sumBiaya += model.totalBiaya;
        sumTotal += model.total;
        sumWeight += model.totalWeight;
      }

      var summary = EggProductionSummary(
        sumHarga: sumHarga,
        sumBiaya: sumBiaya,
        sumTotal: sumTotal,
        sumWeight: sumWeight,
      );

      emit(EggProductionLoaded(models: models, summary: summary));
    } catch (e) {
      emit(EggProductionError(message:
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
