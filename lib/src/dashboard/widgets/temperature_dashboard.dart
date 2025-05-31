// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/temperature_cubit.dart';
import 'package:report_sarang/src/dashboard/widgets/sensor_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TemperatureDashboard extends StatelessWidget {
  const TemperatureDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TemperatureCubit, TemperatureState>(
      listener: (context, state) {
        log('Temperature state: $state');
        if (state is TemperatureLoaded) {
          log('Temperature data loaded: ${state.model.average}');
        }
        if(state is TemperatureError) {
          log('Temperature error: ${state.message}');
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
                _buildTemperatureCard(context),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFEAECF0), thickness: 1),
                const SizedBox(height: 10),
                _buildLineChart(context),
              ],
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<TemperatureCubit, TemperatureState>(
            builder: (_, state) {
              if (state is TemperatureLoaded) {
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
                        sensor.iotSensor?.tempMinThreshold == null
                            ? '0'
                            : sensor.iotSensor!.tempMinThreshold.toString(),
                      ),
                      double.parse(
                        sensor.iotSensor?.tempThreshold == null
                            ? '0'
                            : sensor.iotSensor!.tempThreshold.toString()
                      ),
                      "°C"
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
              'Data Suhu',
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
          context.select((TemperatureCubit cubit) => cubit.selectedCageId);

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
                context.read<TemperatureCubit>().updateSelectedCage(value);
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

  Widget _buildTemperatureCard(BuildContext context) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
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
                    color: const Color(0xFF22EE96),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suhu',
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
                )
              ],
            ),
            if (state is TemperatureLoading)
              const CircularProgressIndicator()
            else if (state is TemperatureLoaded)
              Text(
                '${state.model.average?.toStringAsFixed(1) ?? "0"}°C',
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
      child: BlocBuilder<TemperatureCubit, TemperatureState>(
        builder: (_, state) {
          List<FlSpot> spots = [];

          if (state is TemperatureLoaded) {
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
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${value.toInt()}°C', style: TextStyle(fontSize: 12)),
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
                  color: const Color(0xFF22EE96),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color(0xFF22EE96).withOpacity(0.3), Colors.white],
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