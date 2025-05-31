// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/chicken_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'chicken_chart_state.dart';

class ChickenChartCubit extends Cubit<ChickenChartState> {
  ChickenChartCubit() : super(ChickenChartInitial());

  String selectedDateRange = 'Pilih Tanggal';
  String? selectedCageId;

  void go() async {
    try {
      emit(ChickenChartLoading());

      Response chickenChartResponse = await AppApi.get(
        path: '/v1/dashboard/chart',
        param: {
          'cageId': selectedCageId,
          ...(selectedDateRange != 'Pilih Tanggal' ? {
            'date': selectedDateRange.split(' - ').map((e) => e.split('/').reversed.join('-')).join(',')
          } : {}),
        }
      );

      var model = ChickenChartModel.fromJson(chickenChartResponse.data['data']);

      emit(ChickenChartLoaded(model: model, selectedDateRange: selectedDateRange));
    } catch (e) {
      emit(ChickenChartError(message:
      'Failed to load data ${e.toString()}'));
    }
  }

  void updateSelectedDate(String? dateRange) {
    if(selectedDateRange != dateRange) {
      selectedDateRange = dateRange ?? "Pilih Tanggal";
      go();
    }
  }

  void updateSelectedCage(String cageId) {
    if(selectedCageId != cageId) {
      selectedCageId = cageId;
      go();
    }
  }
}
