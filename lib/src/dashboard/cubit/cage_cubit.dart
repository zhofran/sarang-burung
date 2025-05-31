import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/cage_model.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'cage_state.dart';

class CageCubit extends Cubit<CageState> {
  CageCubit() : super(CageInitial());

  String? selectedCageId;

  void go() async {
    try {
      emit(CageLoading());

      Response cageResponse = await AppApi.get(
        path: '/v1/chicken-cage',
        param: {
          'page': '1',
          'limit': '100',
        },
      );

      var model = (cageResponse.data['data']['data'] as List? ?? [])
          .map((e) => CageModel.fromJson(e))
          .toList();

      emit(CageLoaded(cages: model));
    } catch (e) {
      emit(CageError(message: 'Failed to load data'));
    }
  }

  void selectCage(String cageId) {
    selectedCageId = cageId;
  }
}
