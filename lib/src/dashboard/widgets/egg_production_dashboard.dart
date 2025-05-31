import 'dart:developer';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/egg_production_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EggProductionDashboard extends StatelessWidget {
  const EggProductionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EggProductionCubit, EggProductionState>(
      listener: (context, state) {
        log('EggProduction state: $state');
        if (state is EggProductionLoaded) {
          log('EggProduction data loaded: ${state.models}');
        }
        if (state is EggProductionError) {
          log('EggProduction error: ${state.message}');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFEAECF0), thickness: 1),
                const SizedBox(height: 10),
                _buildLineChart(context),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildSummaryGrid(),
        ],
      ),
    );
  }

  /// **HEADER** - Menampilkan judul dan dropdown kandang
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Produksi Telur',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              DateFormat('MMMM yyyy').format(DateTime.now()),
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        _buildDropdown(context),
      ],
    );
  }

  /// **DROPDOWN** - Pilih kandang
  Widget _buildDropdown(BuildContext context) {
    return BlocBuilder<CageCubit, CageState>(
      builder: (context, cageState) {
        if (cageState is CageLoaded) {
          final selectedCageId = context.select((EggProductionCubit cubit) => cubit.selectedCageId);

          return DropdownButton2<String>(
            items: cageState.cages
                .map(
                  (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
            )
                .toList(),
            value: selectedCageId,
            hint: const Text('Pilih Kandang'),
            onChanged: (value) {
              if (value != null) {
                context.read<EggProductionCubit>().updateSelectedCage(value);
                log('selectedCageId: $value');
              }
            },
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  /// **GRAFIK LINE CHART** - Menampilkan `totalBiaya` & `totalHarga`
  Widget _buildLineChart(BuildContext context) {
    return SizedBox(
      height: 250,
      child: BlocBuilder<EggProductionCubit, EggProductionState>(
        builder: (_, state) {
          List<FlSpot> spotsBiaya = [];
          List<FlSpot> spotsHarga = [];
          List<String> xLabels = [];

          if (state is EggProductionLoaded) {
            for (int i = 0; i < state.models.length; i++) {
              final item = state.models[i];
              final date = item.date;
              final index = i.toDouble();

              spotsBiaya.add(FlSpot(index, (item.totalBiaya as num).toDouble() / 1000));
              spotsHarga.add(FlSpot(index, (item.totalHarga as num).toDouble() / 1000));
              xLabels.add(DateFormat('dd-MM-yyyy').format(date!));
            }
          }

          return LineChart(
            LineChartData(
              gridData: FlGridData(
                show: false,
                drawVerticalLine: false,
                horizontalInterval: 1,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xFF22EE96),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color(0xFF22EE96),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text("Rp ${value.toStringAsFixed(2)}", style: const TextStyle(fontSize: 10)),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < xLabels.length) {
                        return Transform.rotate(
                          angle: -0.5,
                          child: Text(xLabels[index], style: const TextStyle(fontSize: 10)),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spotsBiaya,
                  color: Colors.orange,
                  barWidth: 3,
                  isStrokeCapRound: true,
                ),
                LineChartBarData(
                  spots: spotsHarga,
                  color: Colors.green,
                  barWidth: 3,
                  isStrokeCapRound: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// **GRID RINGKASAN** - Menampilkan **Total Biaya, Total Harga, Total Butir, Total Berat**
  Widget _buildSummaryGrid() {
    return BlocBuilder<EggProductionCubit, EggProductionState>(
      builder: (_, state) {
        if (state is EggProductionLoaded) {
          final summary = [
            {'title': 'Total Harga', 'value': state.summary.sumHarga, 'suffix': 'IDR'},
            {'title': 'Total Biaya', 'value': state.summary.sumBiaya, 'suffix': 'IDR'},
            {'title': 'Total Butir', 'value': state.summary.sumTotal, 'suffix': 'Butir'},
            {'title': 'Total Berat', 'value': state.summary.sumWeight, 'suffix': 'Kg'},
          ];

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
            ),
            itemCount: summary.length,
            itemBuilder: (context, index) {
              return AppCard(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      summary[index]['title'].toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(
                      '${NumberFormat("#,##0").format(summary[index]['value'])} ${summary[index]['suffix']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D593D)),
                    ),
                    const Spacer(),
                    if(summary[index]['suffix'].toString() == "IDR")
                      Text(
                        'IDR',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
