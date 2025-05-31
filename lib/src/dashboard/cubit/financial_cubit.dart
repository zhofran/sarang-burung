import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/models/financial_model.dart';
import 'package:report_sarang/src/dashboard/models/financial_year_model.dart';

part 'financial_state.dart';

class FinancialCubit extends Cubit<FinancialState> {
  FinancialCubit() : super(FinancialInitial());

  FinancialModel? financialModels;
  FinancialData? financialData;

  FinancialYearModel? financialYearModel;
  Data? financialYearData;
  List<FullData> fullData = [];

  // List<FinancialData> financialData = [];
  List<Expense> expense = [];
  
  String? selectedPeriode;
  String selectedDateRange = 'Pilih Tanggal';

  String year = DateFormat('yyyy').format(DateTime.now());

  void go() async {
    try {
      emit(FinancialLoading());

      Response response = await AppApi.get(path: '/auth/expense/year/${int.parse(year)}',);

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

  void fetchYearlyExpenses() async {
    try {
      emit(FinancialLoading());

      Response response = await AppApi.get(path: '/auth/expense/year/${int.parse(year)}');

      if (response.statusCode == 200) {
        financialYearModel = FinancialYearModel.fromJson(response.data);
        financialYearData = financialYearModel?.data.first;
        fullData = financialYearData?.fullData ?? [];

        log('Financial Year Model: $fullData', name: 'Financial Year Model');

        emit(FinancialSuccess());
      }

    } catch (e) {
      emit(FinancialError(message: 'Failed to load data ${e.toString()}'));
    }
  }
}
