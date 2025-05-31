import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/financial_model.dart';

part 'financial_state.dart';

class FinancialCubit extends Cubit<FinancialState> {
  FinancialCubit() : super(FinancialInitial());

  FinancialModel? financialModels;
  FinancialData? financialData;

  // List<FinancialData> financialData = [];
  List<Expense> expense = [];
  
  String? selectedPeriode;
  String selectedDateRange = 'Pilih Tanggal';

  void go() async {
    try {
      emit(FinancialLoading());

      Response response = await AppApi.get(path: '/auth/expense',);

      log('Response: ${response.data['data']}', name: 'FinancialCubit');

      if (response.statusCode == 200) {
        financialModels = FinancialModel.fromJson(response.data); 

        log('Financial Model: $financialModels', name: 'Financial Model');

        emit(FinancialSuccess());
      }

    } catch (e) {
      emit(FinancialError(message: 'Failed to load data ${e.toString()}'));
    }
  }
}
