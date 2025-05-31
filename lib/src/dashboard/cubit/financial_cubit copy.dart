// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';
// import 'package:intl/intl.dart';
// import 'package:report_sarang/env/class/app_env.dart';
// import 'package:report_sarang/src/dashboard/models/financial_model.dart';

// part 'financial_state.dart';

// class FinancialCubit extends Cubit<FinancialState> {
//   FinancialCubit() : super(FinancialInitial());

//   FinancialModel? financialModels;
//   FinancialData? financialData;

//   // List<FinancialData> financialData = [];
//   List<Expense> expense = [];
  
//   String? selectedPeriode;
//   String selectedDateRange = 'Pilih Tanggal';

//   void go() async {
//     try {
//       emit(FinancialLoading());

//       // final dateFormat = DateFormat('dd/MM/yyyy');
//       // final parts = selectedDateRange.split(' - ');
//       // if (parts.length != 2) {
//       //   throw Exception('Invalid date range format');
//       // }
//       // final startDate = dateFormat.parse(parts[0]);
//       // final endDate = dateFormat.parse(parts[1]);
//       // final startDateStr = DateFormat('yyyy-MM-dd').format(startDate);
//       // final endDateStr = DateFormat('yyyy-MM-dd').format(endDate);

//       Response response = await AppApi.get(
//         path: '/auth/expense',
//         // param: {
//         //   'period_type': selectedPeriode,
//         //   'start_date': startDateStr,
//         //   'end_date': endDateStr,
//         // },
//       );

//       log('Response: ${response.data['data']}', name: 'FinancialCubit');

//       // log('Response: $startDateStr', name: 'Start Date');
//       // log('Response: $endDateStr', name: 'End Date');

//       if (response.statusCode == 200) {
//         financialModels = FinancialModel.fromJson(response.data['data']); 

//         log('Financial Model: $financialModels', name: 'Financial Model');

//         // emit(FinancialLoaded(models: models));
//         emit(FinancialSuccess());
//       }

//     } catch (e) {
//       emit(FinancialError(message: 'Failed to load data ${e.toString()}'));
//     }
//   }

//   // void detail() async {
//   //   try {
//   //     emit(FinancialLoading());

//   //     final dateFormat = DateFormat('dd/MM/yyyy');
//   //     final parts = selectedDateRange.split(' - ');
//   //     if (parts.length != 2) {
//   //       throw Exception('Invalid date range format');
//   //     }
//   //     final startDate = dateFormat.parse(parts[0]);
//   //     final endDate = dateFormat.parse(parts[1]);
//   //     final startDateStr = DateFormat('yyyy-MM-dd').format(startDate);
//   //     final endDateStr = DateFormat('yyyy-MM-dd').format(endDate);

//   //     Response response = await AppApi.get(
//   //       path: '/financial/summary',
//   //       param: {
//   //         'period_type': 'monthly',
//   //         'start_date': '19/05/2025',
//   //         'end_date': '20/05/2025',
//   //       },
//   //     );

//   //     log('Response: ${response.data}', name: 'FinancialCubit');
//   //     log('Response: $startDateStr', name: 'Start Date');
//   //     log('Response: $endDateStr', name: 'End Date');

//   //     if (response.statusCode == 200) {
//   //       FinancialModel models = FinancialModel.fromJson(response.data);
//   //       financialModels = models;
//   //       otherCosts = models.otherCosts;

//   //       // emit(FinancialLoaded(models: models));
//   //       emit(FinancialSuccess());
//   //     }

//   //   } catch (e) {
//   //     emit(FinancialError(message: 'Failed to load data ${e.toString()}'));
//   //   }
//   // }



//   void updateSelectedDate(String? dateRange) {
//     if(selectedDateRange != dateRange) {
//       selectedDateRange = dateRange ?? "Pilih Tanggal";
//       log('Selected date range: $selectedDateRange');
//       // go();
//     }
//   }

// ignore_for_file: file_names

//   void updateSelectedPeriode(String periode) {
//     emit(FinancialLoading());
//     if(selectedPeriode != periode) {
//       selectedPeriode = periode;
//       emit(FinancialSuccess());
//     }
//   }
// }
