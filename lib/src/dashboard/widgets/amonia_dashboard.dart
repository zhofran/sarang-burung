// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/amonia_cubit.dart';
import 'package:report_sarang/src/dashboard/widgets/sensor_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AmoniaDashboard extends StatelessWidget {
  const AmoniaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AmoniaCubit, AmoniaState>(
      listener: (context, state) {
        log('Amonia state: $state');
        if (state is AmoniaLoaded) {
          log('Amonia data loaded: ${state.model.average}');
        }
        if(state is AmoniaError) {
          log('Amonia error: ${state.message}');
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
                const SizedBox(height: 10),
                _buildAmoniaCard(context),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFEAECF0), thickness: 1),
                const SizedBox(height: 10),
                _buildLineChart(context),
              ],
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<AmoniaCubit, AmoniaState>(
            builder: (_, state) {
              if (state is AmoniaLoaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Agar tidak bentrok dengan scroll utama
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: state.model.sensors.length == 1 ? 1 : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: state.model.sensors.length == 1 ? 2.5 : 1.2,
                  ),
                  itemCount: state.model.sensors.length,
                  itemBuilder: (context, index) {
                    final sensor = state.model.sensors[index];
                    return sensorCard(
                      sensor.code!,
                      sensor.lastestValue!,
                      AppParse.isSensorAlive(sensor),
                      double.parse(
                        sensor.iotSensor?.amoniaMinThreshold == null
                            ? '0'
                            : sensor.iotSensor!.amoniaMinThreshold.toString(),
                      ),
                      double.parse(
                        sensor.iotSensor?.amoniaThreshold == null
                            ? '0'
                            : sensor.iotSensor!.amoniaThreshold.toString()
                      ),
                      "PPM",
                    );
                  },
                );
              }
              return const SizedBox(); // Tidak menampilkan apa pun jika belum loaded
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Amonia',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppConstant.black,
              ),
            ),
            Text(
              AppParse.formattedDate(
                date: DateTime.now().toString(),
                format: 'MMMM yyyy',
              ),
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppConstant.black,
              ),
            ),
          ],
        ),
        _buildDropdown(context),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return BlocBuilder<CageCubit, CageState>(
      builder: (context, cageState) {
        if (cageState is CageLoaded) {
          final selectedCageId =
          context.select((AmoniaCubit cubit) => cubit.selectedCageId);

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
                context.read<AmoniaCubit>().updateSelectedCage(value);
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

  Widget _buildAmoniaCard(BuildContext context) {
    return BlocBuilder<AmoniaCubit, AmoniaState>(
      builder: (_, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE6922),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amonia',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: AppConstant.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Kandang 1',
                      style: GoogleFonts.outfit(
                        color: AppConstant.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (state is AmoniaLoading)
              const CircularProgressIndicator()
            else if (state is AmoniaLoaded)
              Text(
                '${state.model.average?.toString() ?? "0"} PPM',
                style: GoogleFonts.outfit(
                  color: AppConstant.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLineChart(BuildContext context) {
    return SizedBox(
      height: 250,
      child: BlocBuilder<AmoniaCubit, AmoniaState>(
        builder: (_, state) {
          List<FlSpot> spots = [];

          if (state is AmoniaLoaded) {
            spots = state.model.chart
                .map(
                  (sensor) => FlSpot(
                double.parse(
                    sensor.x!.split(':').first == '00' ? '0' : sensor.x!.split(':').first),
                sensor.y!,
              ),
            )
                .toList();
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
                    color: Color(0xFFEE6922),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color(0xFFEE6922),
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
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(value.toStringAsFixed(3), style: TextStyle(fontSize: 12)),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('${value.toInt()}:00', style: TextStyle(fontSize: 12)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots.isNotEmpty ? spots : [const FlSpot(0, 0)],
                  color: const Color(0xFFEE6922),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color(0xFFEE6922).withOpacity(0.3), Colors.white],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}