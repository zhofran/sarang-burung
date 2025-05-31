import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/extension/on_context.dart';
import 'package:report_sarang/env/widget/app_button.dart';
import 'package:report_sarang/src/report/cubit/report_cubit.dart';
import 'package:report_sarang/src/report/models/panen_telur_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ReportDetailPage extends StatefulWidget {
  const ReportDetailPage({super.key});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  bool isSwitched = true;

  final eggWeight = TextEditingController();

  List<PanenTelurModel> totalPanenTelur = [];

  @override
  void initState() {
    super.initState();
    context.read<ReportCubit>().calculateTotalEggWeight();
    context.read<ReportCubit>().weightPerEgg();
  }

  @override
  Widget build(BuildContext context) {
    var reportCubit = context.watch<ReportCubit>();
    var args = context.modal<Map<String, dynamic>?>();

    totalPanenTelur = args?['totalPanenTelur'];

    // log('Hasil arguments: ${totalPanenTelur.map((e) => e.toJson()).toList()}', name: 'Log Report Detail Page');

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
                reportCubit.completePanen();
                context.toReplacementNamed(route: AppRoute.dashboardPage.path);
              },
              alignment: AlignmentDirectional.centerEnd,
            ),
            Text(
              'Kembali',
              style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        actions: [
          Icon(Icons.location_on, color: Color(0xFF0F6646)),
          Text(
            '${args?['location']}',
            style: GoogleFonts.outfit(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: BlocConsumer<ReportCubit, ReportState>(
        listener: (_, state) {
          if (state is ReportFailed) {
            Alert(
              context: context,
              type: AlertType.error,
              title: "Whoops Error",
              desc: state.message,
              style: AlertStyle(
                  titleStyle: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                  descStyle: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              buttons: [
                DialogButton(
                  onPressed: () => Navigator.pop(context),
                  color: Color(0xFF0F6646),
                  border: Border.all(color: Color(0xFF0F6646)),
                  child: Text(
                    "OK",
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ).show();
          }

          if (state is ReportSuccess) {
            Alert(
              context: context,
              type: AlertType.success,
              title: "Simpan Berhasil",
              desc: "Data panen telur berhasil tersimpan",
              style: AlertStyle(
                  titleStyle: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                  descStyle: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              buttons: [
                DialogButton(
                  onPressed: () {
                    context.toReplacementNamed(
                      route: AppRoute.dashboardPage.path
                    );
                  },
                  color: Color(0xFF0F6646),
                  border: Border.all(color: Color(0xFF0F6646)),
                  child: Text(
                    "OK",
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ).show();
          }
        },
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.81,
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Catatan Panen Telur',
                      style: GoogleFonts.outfit(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${args?['batch']}',
                          style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${args?['cage']}',
                          style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Detail Rak',
                        style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.width * 1,
                      child: ListView.builder(
                        itemCount: totalPanenTelur.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rak:',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${totalPanenTelur[index].rakInfo}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Telur Utuh:',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${totalPanenTelur[index].goodEgg} Butir',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Telur Rusak:',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${totalPanenTelur[index].badEgg} Butir',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.width * 0.15,
                      // color: Colors.green,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Telur Utuh:',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${args?['goodEggs']} Butir',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Telur Rusak:',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${args?['badEggs']} Butir',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isSwitched == true
                                  ? '${args?['goodEggs']} Butir x 0,062 Kg'
                                  : '${args?['goodEggs']} Butir',
                              style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Transform.scale(
                              scale: 1.0,
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) => setState(() {
                                  isSwitched = value;
                                }),
                                activeColor: Color(0xFF0F6646),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.grey.shade300,
                              ),
                            )
                          ],
                        ),
                        isSwitched == false
                            ? Visibility(
                                visible: true,
                                child: TextFormField(
                                  controller: eggWeight,
                                  decoration: InputDecoration(
                                    hintText: 'Masukan Berat Telur',
                                    hintStyle: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        // color: Color(0xFF0F6646),
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        // color: Color(0xFF0F6646),
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                  ),
                                  // cursorColor: Color(0xFF0F6646),
                                  keyboardType: TextInputType.number,
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Berat Telur:',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${isSwitched == true ? (args!['goodEggs'] * reportCubit.defaultEggWeight).toStringAsFixed(3).replaceAll('.', ',') : eggWeight.text == '' ? (args!['goodEggs'] * reportCubit.defaultEggWeight).toStringAsFixed(3).replaceAll('.', ',') : (args!['goodEggs'] * double.parse(eggWeight.text)).toStringAsFixed(3).replaceAll('.', ',')} Kg',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: AppButton(
            backgroundColor: Color(0xFF0F6646),
            label: 'Simpan',
            onTap: () {
              reportCubit.postWarehouse(
                cageId: args?['cageId'],
                weight: isSwitched == true
                ? double.parse((args?['goodEggs'] * reportCubit.defaultEggWeight).toStringAsFixed(3)).toInt()
                : eggWeight.text == ''
                  ? double.parse((args?['goodEggs'] * reportCubit.defaultEggWeight).toStringAsFixed(3)).toInt()
                  : double.parse((args?['goodEggs'] * double.parse(eggWeight.text)).toStringAsFixed(3)).toInt(),
                category: "EGG",
                journalTypeId: "ec963206-7372-463c-8073-cfbe0a4e62a9",
                batchId: args?['batchId'],
                detailRak: totalPanenTelur.map((e) => e.toJson()).toList()
              );
            },
          ),
        ),
      ),
    );
  }
}
