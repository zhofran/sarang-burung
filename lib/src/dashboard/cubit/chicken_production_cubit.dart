// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/chicken_production_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'chicken_production_state.dart';

class ChickenProductionCubit extends Cubit<ChickenProductionState> {
  ChickenProductionCubit() : super(ChickenProductionInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(ChickenProductionLoading());

      Response temperaturesResponse = await AppApi.get(
        path: '/v1/dashboard/chart-chicken',
        param: {
          'cage_id': selectedCageId,
          'groupBy': 'days',
          'startDate': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
          'endDate': DateTime.now().toIso8601String(),
        },
      );

      log('temperaturesResponse: ${temperaturesResponse.data['data']}');

      var models = (temperaturesResponse.data['data'] as List)
          .map((e) => ChickenProductionModel.fromJson(e))
          .toList();

      var sumHarga = 0;
      var sumBiaya  = 0;
      var sumTotal  = 0;

      for (var model in models) {
        sumHarga += model.totalHarga;
        sumBiaya += model.totalBiaya;
        sumTotal += model.total;
      }

      var summary = ChickenProductionSummary(
        sumHarga: sumHarga,
        sumBiaya: sumBiaya,
        sumTotal: sumTotal,
      );

      emit(ChickenProductionLoaded(models: models, summary: summary));
    } catch (e) {
      emit(ChickenProductionError(message:
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
