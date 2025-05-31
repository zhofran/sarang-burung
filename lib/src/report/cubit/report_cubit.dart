// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/report/models/cage_model.dart';
import 'package:report_sarang/src/report/models/panen_telur_model.dart';
import 'package:report_sarang/src/report/models/rak_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  final List<PanenTelurModel> totalPanenTelur = [];
  
  late RakModel resultRak;
  late CageModel resultCage;

  double defaultEggWeight = 0.0;

  Future weightPerEgg() async{
    Response response = await AppApi.get(
      path: '/v1/price',
      param: {
        'page': 1,
        'limit': 10
      }
    );

    if (response.statusCode == 200) {
      defaultEggWeight = response.data['data']['data'][1]['weightPerUnit'];
      emit(ReportSuccessWeight(eggWeight: defaultEggWeight));
    }
  }

  Future fetchDataRak({ required String? uuid }) async{
    try {
      emit(ReportLoading());

      final response = await AppApi.get(
        path: '/v1/chicken-cage-rack/$uuid'
      );

      if (response.data['status'] == 200) {
        resultRak = RakModel.fromJson(response.data['data']);
        resultCage = CageModel.fromJson(response.data['data']['cage']);

        emit(ReportSuccess());
      }

    } catch (e) {
      log('Error : $e', name: 'Catch Report Cubit Future fetchDataRak');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Get Voucher',
        content: e.toString(),
        type: AppAPIType.get,
      );

      emit(ReportError(model: model));
    }
  }

  Future postWarehouse({ 
    required String cageId, 
    required int weight,
    required String category,
    required String journalTypeId,
    required String batchId,
    required List detailRak,
  }) async{

    try {
      emit(ReportLoading());

      Response response = await AppApi.post(
        path: '/v1/warehouse-transaction',
        formdata: {
          "cageId": cageId,
          "type": "IN",
          "weight": weight < 1.0 ? 1 : weight,
          "haversts": detailRak,
          "category": category,
          "journalTypeId": journalTypeId,
          "batchId": batchId,
          "isEndOfBatch": false,
          "dateCreated": DateTime.now().toUtc().toIso8601String(),
        }
      );
      
      log('Hasil post: ${response.data}', name: 'Log Report Cubit Future postWarehouse');

      if (response.data['status'] == 200) {
        log('Berhasil menambahkan data ke warehouse', name: 'Log Report Cubit Future postWarehouse');
        emit(ReportSuccess());
      } else {
        log('Gagal menambahkan data ke warehouse', name: 'Log Report Cubit Future postWarehouse');
        emit(ReportFailed(message: response.data['message']));
      }
    } catch (e, stacktrace) {
      // log('Error : $e', name: 'Catch Report Cubit Future postWarehouse');
      log('Error : $e\nStack Trace: $stacktrace', name: 'Catch Report Cubit Future postWarehouse');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Get Voucher',
        content: e.toString(),
        type: AppAPIType.get,
      );

      emit(ReportError(model: model));
    }

  }

  // Fungsi untuk menambahkan data ke array
  void addPanenData(PanenTelurModel newData) {
    // Cek apakah rakId dari newData sudah ada dalam daftar
    bool isDuplicate = totalPanenTelur.any((item) => item.rakId == newData.rakId);

    if (!isDuplicate) {
      totalPanenTelur.add(newData);
      emit(ReportSuccess());
      log('Data berhasil ditambahkan: ${newData.rakId}', name: 'ReportCubit');
    } else {
      emit(ReportFailed(message: 'Data dengan rakId ${newData.rakId} sudah ada, tidak ditambahkan'));
      log('Data dengan rakId ${newData.rakId} sudah ada, tidak ditambahkan.', name: 'ReportCubit');
    }
  }

  // void addPanenData(PanenTelurModel newData) {
  //   log('Hasil dari total panen telur: ${totalPanenTelur.contains(newData.rakId)}', name: 'Log report cubit');
  //   log('Hasil dari new Data: ${newData.rakId}', name: 'Log report cubit');
  //   if (!totalPanenTelur.contains(newData)) {
  //     totalPanenTelur.add(newData);
  //     emit(ReportSuccess()); 
  //   } else {
  //     log('Data sudah ada, tidak ditambahkan lagi.', name: 'ReportCubit');
  //   }// Emit state baru dengan data terbaru
  // }

  // Fungsi untuk menyelesaikan proses dan mendapatkan seluruh data
  void completePanen() {
    log('Data Panen Selesai: $totalPanenTelur');
    totalPanenTelur.clear(); // Reset data setelah selesai
    emit(ReportInitial());
  }

  void calculateTotalEggs() {
    int totalGoodEggs = totalPanenTelur.fold(0, (sum, item) => sum + (item.goodEgg ?? 0));
    int totalBadEggs = totalPanenTelur.fold(0, (sum, item) => sum + (item.badEgg ?? 0));

    emit(ReportSuccess());
  }

  void calculateTotalEggWeight({double? customWeight}) {
    double weightPerEgg = customWeight ?? defaultEggWeight;
    double totalWeight = totalGoodEggs * weightPerEgg;

    emit(ReportSuccess());
  }

  // Getter to calculate total egg weight using default weight
  double get totalWeight => totalGoodEggs * defaultEggWeight;

  // Getter untuk mengambil total telur dari state
  int get totalGoodEggs => totalPanenTelur.fold(0, (sum, item) => sum + (item.goodEgg ?? 0));
  int get totalBadEggs => totalPanenTelur.fold(0, (sum, item) => sum + (item.badEgg ?? 0));

  // Mengembalikan daftar data panen yang sudah ditambahkan
  List<PanenTelurModel> get panenList => totalPanenTelur;

  
}
