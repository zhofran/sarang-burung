// ignore_for_file: use_build_context_synchronously

import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_button.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/chicken_chart_cubit.dart';
import 'package:report_sarang/src/dashboard/models/chicken_chart_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'date_range_picker_widget.dart';

class ChickenPieChart extends StatefulWidget {
  const ChickenPieChart({super.key});

  @override
  State<ChickenPieChart> createState() => _ChickenPieChartState();
}

class _ChickenPieChartState extends State<ChickenPieChart> {
  int touchedIndex = 1;

  void _pickDateRange() async {
    final selectedRange = context.read<ChickenChartCubit>().selectedDateRange;
    final result = await DateRangePickerWidget.showDatePickerDialog(
      context,
      initialRange: selectedRange,
    );

    context.read<ChickenChartCubit>().updateSelectedDate(result);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grafik Ayam',
            style: GoogleFonts.outfit(
              fontSize: 20,
              color: AppConstant.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown(context),
              BlocSelector<ChickenChartCubit, ChickenChartState, String>(
                selector: (state) {
                  if (state is ChickenChartLoaded) {
                    return state.selectedDateRange;
                  }
                  return 'Pilih Tanggal'; // Default jika state belum `Loaded`
                },
                builder: (context, selectedDateRange) {
                  return AppButton(
                    padding: 9,
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xFF999999),
                    textColor: const Color(0xFF667085),
                    onTap: () => _pickDateRange(), // Perbaikan pemanggilan fungsi
                    label: selectedDateRange,
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          _buildLegend(),
          const SizedBox(height: 10),
          BlocBuilder<ChickenChartCubit, ChickenChartState>(
            builder: (_, state) {
              if (state is ChickenChartLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ChickenChartError) {
                return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
              }
              if (state is ChickenChartLoaded) {
                if(state.model.alive == 0 && state.model.dead == 0 && state.model.aliveInSick == 0 && state.model.deadDueToIllness == 0 && state.model.productive == 0 && state.model.feedChange == 0 && state.model.spent == 0 && state.model.rejuvenation == 0) {
                  return const Center(child: Text("Tidak ada data"));
                }
                return AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      startDegreeOffset: 270, // Membalik posisi awal
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 60, // Membuat efek doughnut
                      sections: showingSections(state.model),
                    ),
                  ),
                );
              }
              return const Center(child: Text("Tidak ada data"));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 12,
      runSpacing: 8,
      children: [
        _buildLegendItem(Colors.green, "Ayam Hidup dan Sehat"),
        _buildLegendItem(Colors.orange, "Ayam Mati Tanpa Penyakit"),
        _buildLegendItem(Colors.blue, "Ayam Hidup Tanpa Penyakit"),
        _buildLegendItem(Colors.red, "Ayam Mati Karena Penyakit"),
        _buildLegendItem(Colors.purple, "Ayam Produktif"),
        _buildLegendItem(Colors.cyan, "Ayam Dalam Proses Ganti Pakan"),
        _buildLegendItem(Colors.amber, "Ayam Tidak Produktif"),
        _buildLegendItem(Colors.brown, "Ayam Dalam Proses Peremajaan"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(ChickenChartModel model) {
    final data = [
      {'label': "Ayam Hidup dan Sehat", 'value': model.alive.toDouble(), 'color': Colors.green},
      {'label': "Ayam Mati Tanpa Penyakit", 'value': model.dead.toDouble(), 'color': Colors.orange},
      {'label': "Ayam Hidup Tanpa Penyakit", 'value': model.aliveInSick.toDouble(), 'color': Colors.blue},
      {'label': "Ayam Mati Karena Penyakit", 'value': model.deadDueToIllness.toDouble(), 'color': Colors.red},
      {'label': "Ayam Produktif", 'value': model.productive.toDouble(), 'color': Colors.purple},
      {'label': "Ayam Dalam Proses Ganti Pakan", 'value': model.feedChange.toDouble(), 'color': Colors.cyan},
      {'label': "Ayam Tidak Produktif", 'value': model.spent.toDouble(), 'color': Colors.amber},
      {'label': "Ayam Dalam Proses Peremajaan", 'value': model.rejuvenation.toDouble(), 'color': Colors.brown},
    ];

    return data.map((entry) {
      final isTouched = data.indexOf(entry) == touchedIndex;
      return PieChartSectionData(
        color: entry['color'] as Color,
        value: entry['value'] as double,
        title: isTouched
            ? '${entry['label']}\n${(entry['value'] as double).toStringAsFixed(1)} ekor'
            : '',
        radius: isTouched ? 90 : 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  Widget _buildDropdown(BuildContext context) {
    return BlocBuilder<CageCubit, CageState>(
      builder: (context, cageState) {
        if (cageState is CageLoaded) {
          final selectedCageId = context.select((ChickenChartCubit cubit) => cubit.selectedCageId);

          return DropdownButton2<String>(
            items: cageState.cages
                .map(
                  (e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
              ),
            )
                .toList(),
            hint: const Text('Pilih Kandang'),
            onChanged: (value) {
              if (value != null) {
                context.read<ChickenChartCubit>().updateSelectedCage(value);
              }
            },
            value: selectedCageId,
            style: GoogleFonts.outfit(
              fontSize: 16,
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
