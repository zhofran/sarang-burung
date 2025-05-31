import 'dart:developer';

import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/log_sensor_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LogSensor extends StatefulWidget {
  const LogSensor({super.key});

  @override
  State<LogSensor> createState() => _LogSensorState();
}

class _LogSensorState extends State<LogSensor> {
  List<Map<String, dynamic>> sensors = [
    {
      'lokasi': 'Kandang 1',
      'kandang': 'Kandang 1',
      'tanggal': '2022-10-10',
      'status': 'Hidup',
      'deskripsi': 'Kipas dan lampu menyala'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Log Kipas Dan Lampu",
            style: GoogleFonts.outfit(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w700),
          ),
          _buildDropdown(context),
          const SizedBox(height: 10),
          BlocBuilder<LogSensorCubit, LogSensorState>(
            builder: (_, state) {
              if (state is LogSensorLoaded) {
                return SizedBox(
                  height: 300, // 🔥 Tentukan tinggi tetap di sini
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ListView.builder(
                            shrinkWrap: true, // 🚀 Agar tidak mengambil seluruh ruang
                            physics: const NeverScrollableScrollPhysics(), // 🚫 Mencegah konflik scroll
                            itemCount: state.models.length,
                            itemBuilder: (_, index) {
                              final model = state.models[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.sensor?.cage?.site?.name ?? '',
                                              style: GoogleFonts.outfit(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              model.sensor?.cage?.name ?? '',
                                              style: GoogleFonts.outfit(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          AppParse.formattedDate(
                                            date: model.createdAt.toString(),
                                            format: 'd MMMM yyyy HH:mm',
                                          ),
                                          style: GoogleFonts.outfit(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "Status",
                                          style: GoogleFonts.outfit(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: model.status == 1 ? Colors.green : Colors.red,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            model.status == 1 ? 'Hidup' : 'Mati',
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "Deskripsi",
                                          style: GoogleFonts.outfit(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Spacer(),
                                        Text(
                                          model.relayDesc,
                                          style: GoogleFonts.outfit(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is LogSensorError) {
                return Center(
                  child: Text(
                    state.message,
                    style: GoogleFonts.outfit(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return BlocBuilder<CageCubit, CageState>(
      builder: (context, cageState) {
        if (cageState is CageLoaded) {
          final selectedCageId =
          context.select((LogSensorCubit cubit) => cubit.selectedCageId);

          return DropdownButton2<String>(
            items: cageState.cages
                .map(
                  (e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
              ),
            )
                .toList(),
            value: selectedCageId,
            hint: const Text('Pilih Kandang'),
            onChanged: (value) {
              if (value != null) {
                context.read<LogSensorCubit>().updateSelectedCage(value);
                log('selectedCageId: $value');
              }
            },
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppConstant.black,
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
