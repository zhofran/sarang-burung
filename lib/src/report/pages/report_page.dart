import 'dart:developer';

import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/extension/on_context.dart';
import 'package:report_sarang/env/widget/app_button.dart';
import 'package:report_sarang/env/widget/app_textfield.dart';
import 'package:report_sarang/src/report/cubit/report_cubit.dart';
import 'package:report_sarang/src/report/models/panen_telur_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Reportpage extends StatefulWidget {
  const Reportpage({super.key});

  @override
  State<Reportpage> createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {
  final goodEgg = TextEditingController();
  final badEgg = TextEditingController();

  String uuid = '';

  @override
  Widget build(BuildContext context) {
    var reportCubit = context.watch<ReportCubit>();

    return BlocBuilder<ReportCubit, ReportState>(
      builder: (_, state) {
        if (state is ReportSuccess) {
          var dataRak = reportCubit.resultRak;
          var dataCage = reportCubit.resultCage;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 150,
              leading: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.only(left: 10),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                      reportCubit.completePanen();
                    },
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                  Text(
                    'Kembali',
                    style: GoogleFonts.outfit(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              actions: [
                Icon(Icons.location_on, color: Color(0xFF0F6646)),
                Text(
                  '${dataCage.site!.address}',
                  style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 20),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                // color: Colors.lime,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Panen Telur',
                            style: GoogleFonts.outfit(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${dataRak.batch!.name}',
                            style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${dataCage.name} / ${dataRak.name}',
                            style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Form(
                            child: Column(
                              children: [
                                AppTextField(
                                  withIcon: false,
                                  label: 'Jumlah Telur Bagus',
                                  hint: 'Masukan jumlah telur bagus',
                                  textController: goodEgg,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Jumlah telur bagus tidak boleh kosong';
                                    }
                                    return null;
                                  }
                                ),
                                AppTextField(
                                  withIcon: false,
                                  label: 'Jumlah Telur Rusak',
                                  hint: 'Masukan jumlah telur rusak',
                                  textController: badEgg,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Jumlah telur rusak tidak boleh kosong';
                                    }
                                    return null;
                                  }
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: AppButton(
                            label: 'Selesai',
                            backgroundColor: Color(0xFF0F6646),
                            onTap: () {
                              Alert(
                                context: context,
                                // type: AlertType.warning,
                                image: Image(image: Svg(AppAsset.iconQuestion)),
                                title: "Apakah Anda Yakin ?",
                                desc:
                                    "Apakah anda yakin untuk menyimpan data panen telur?",
                                style: AlertStyle(
                                    titleStyle: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    descStyle: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                buttons: [
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xFF0F6646)),
                                    child: Text(
                                      "Kembali",
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        color: Color(0xFF0F6646),
                                      ),
                                    ),
                                  ),
                                  DialogButton(
                                    onPressed: () {
                                      // Navigator.pop(context);
                                      // reportCubit.completePanen();
                                      final jumlahTelur = int.tryParse(goodEgg.text) ?? 0;
                                      final telurRusak = int.tryParse(badEgg.text) ?? 0;

                                      final panenData = PanenTelurModel(
                                        batchInfo: dataRak.batch!.name,
                                        cageInfo: dataCage.name,
                                        rakId: dataRak.id,
                                        rakInfo: dataRak.name,
                                        goodEgg: jumlahTelur,
                                        badEgg: telurRusak,
                                      );

                                      // log('Batch ID: ${dataRak.batchId}', name: 'Log Report Page');

                                      reportCubit.addPanenData(panenData);
                                      reportCubit.calculateTotalEggs();
                                      reportCubit.calculateTotalEggWeight();
                                      reportCubit.weightPerEgg();
                                      
                                      context.toNamed(
                                        route: AppRoute.reportDetailPage.path,
                                        arguments: {
                                          'totalPanenTelur': reportCubit.totalPanenTelur,
                                          'location': dataCage.site!.address,
                                          'batchId': dataRak.batchId,
                                          'batch': dataRak.batch!.name,
                                          'cageId': dataCage.id,
                                          'cage': dataCage.name,
                                          'goodEggs': reportCubit.totalGoodEggs,
                                          'badEggs': reportCubit.totalBadEggs
                                        }
                                      );

                                      // log('Hasil total telur: ${reportCubit.totalPanenTelur}', name: 'Log Report Cubit Simpan');
                                    },
                                    color: Color(0xFF0F6646),
                                    border: Border.all(color: Color(0xFF0F6646)),
                                    child: Text(
                                      "Simpan",
                                      style: GoogleFonts.outfit(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                ],
                              ).show();
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: AppButton(
                            label: 'Lanjut',
                            backgroundColor: Colors.white,
                            borderColor: Color(0xFF0F6646),
                            textColor: Color(0xFF0F6646),
                            onTap: () {
                              // context.read<ScannerCubit>().resetScanner();
                              
                              final jumlahTelur = int.tryParse(goodEgg.text) ?? 0;
                              final telurRusak = int.tryParse(badEgg.text) ?? 0;

                              final panenData = PanenTelurModel(
                                batchInfo: dataRak.batch!.name,
                                cageInfo: dataCage.name,
                                rakId: dataRak.id,
                                rakInfo: dataRak.name,
                                goodEgg: jumlahTelur,
                                badEgg: telurRusak,
                              );

                              // reportCubit.addPanenData(panenData);
                              context.read<ReportCubit>().addPanenData(panenData);

                              log('Total Panen Telur Saat Ini: ${context.read<ReportCubit>().panenList.length}', name: 'ReportCubit');

                              goodEgg.clear();
                              badEgg.clear();

                              // context.toNamed(
                              //   route: AppRoute.scannerPage.path,
                              //   arguments: {
                              //     'route': AppRoute.reportPage.path
                              //   }
                              // );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
