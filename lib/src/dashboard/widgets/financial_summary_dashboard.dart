// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_sarang/env/extension/app_function.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/models/financial_model.dart';

class FinancialSummaryDashboard extends StatefulWidget {
  final List<String> period_type;

  const FinancialSummaryDashboard({super.key, required this.period_type});

  @override
  State<FinancialSummaryDashboard> createState() => _FinancialSummaryDashboardState();
}

class _FinancialSummaryDashboardState extends State<FinancialSummaryDashboard> {
  @override
  Widget build(BuildContext context) {
    final finanCubit = context.watch<FinancialCubit>();

    return BlocListener<FinancialCubit, FinancialState>(
      listener: (context, state) {
        log('FinancialSummary state: $state');
        if (state is FinancialLoaded) {
          log('FinancialSummary data loaded: ${state.models}');
        }
        if (state is FinancialError) {
          log('FinancialSummary error: ${state.message}');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, finanCubit),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFEAECF0), thickness: 1),
                const SizedBox(height: 10),
                _buildLineChart(context, finanCubit),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // _buildSummaryGrid(),
        ],
      ),
    );
  }

  /// **HEADER** - Menampilkan judul dan dropdown financial
  Widget _buildHeader(BuildContext context, FinancialCubit finanCubit) {
    // void _pickDateRange() async {
    //   final selectedRange = finanCubit.selectedDateRange;
    //   final result = await DateRangePickerWidget.showDatePickerDialog(
    //     context,
    //     initialRange: selectedRange,
    //   );

    //   // finanCubit.updateSelectedDate(result);
    //   finanCubit.go();
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Summary',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              DateFormat('yyyy').format(DateTime.now()),
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// **GRAFIK LINE CHART** - Menampilkan `totalBiaya` & `totalHarga`
  Widget _buildLineChart(BuildContext context, FinancialCubit finanCubit) {
    return SizedBox(
      height: 250,
      child: BlocBuilder<FinancialCubit, FinancialState>(
        builder: (_, state) {
          // final dataList = finanCubit.financialModels?.data ?? [];
          final dummyData = [
            FinancialData(
              month: 1,
              year: 2023,
              grandTotalCost: 1000000,
              expenses: [
                Expense(name: 'Expense 1', amount: '500000'),
                Expense(name: 'Expense 2', amount: '300000'),
                Expense(name: 'Expense 3', amount: '1000000'),
              ],
            ),
            FinancialData(
              month: 2,
              year: 2023,
              grandTotalCost: 1200000,
              expenses: [
                Expense(name: 'Expense 1', amount: '600000'),
                Expense(name: 'Expense 2', amount: '400000'),
                Expense(name: 'Expense 3', amount: '700000'),
              ],
            ),
            FinancialData(
              month: 3,
              year: 2023,
              grandTotalCost: 1500000,
              expenses: [
                Expense(name: 'Expense 1', amount: '700000'),
                Expense(name: 'Expense 2', amount: '500000'),
                Expense(name: 'Expense 3', amount: '100000'),
              ],
            ),
            FinancialData(
              month: 4,
              year: 2023,
              grandTotalCost: 1800000,
              expenses: [
                Expense(name: 'Expense 1', amount: '800000'),
                Expense(name: 'Expense 2', amount: '600000'),
                Expense(name: 'Expense 3', amount: '1200000'),
              ],
            ),
            FinancialData(
              month: 5,
              year: 2023,
              grandTotalCost: 2000000,
              expenses: [
                Expense(name: 'Expense 1', amount: '900000'),
                Expense(name: 'Expense 2', amount: '700000'),
                Expense(name: 'Expense 3', amount: '200000'),
              ],
            ),
            FinancialData(
              month: 6,
              year: 2023,
              grandTotalCost: 2200000,
              expenses: [
                Expense(name: 'Expense 1', amount: '1000000'),
                Expense(name: 'Expense 2', amount: '800000'),
                Expense(name: 'Expense 3', amount: '0'),
              ],
            ),
          ];
          final sortedDataList = List<FinancialData>.from(dummyData)
            ..sort((a, b) => DateTime(a.year ?? 0, a.month ?? 1).compareTo(DateTime(b.year ?? 0, b.month ?? 1)));

          // Collect unique expense names
          Set<String> uniqueExpenses = {};
          for (var data in sortedDataList) {
            for (var expense in data.expenses) {
              uniqueExpenses.add(expense.name ?? '');
            }
          }

          // Prepare data for each expense
          Map<String, List<FlSpot>> expenseSpots = {};
          for (var expenseName in uniqueExpenses) {
            List<FlSpot> spots = [];
            for (int i = 0; i < sortedDataList.length; i++) {
              final data = sortedDataList[i];
              final expense = data.expenses.firstWhere(
                (e) => e.name == expenseName,
                orElse: () => Expense(name: expenseName, amount: '0'),
              );
              double amount = double.tryParse(expense.amount ?? '0') ?? 0;
              spots.add(FlSpot(i.toDouble(), amount));
            }
            expenseSpots[expenseName] = spots;
          }

          // Define colors for each expense line
          List<Color> colors = [
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.orange,
            Colors.purple,
            Colors.yellow,
          ];
          int colorIndex = 0;

          // Create LineChartBarData for each expense
          List<LineChartBarData> lineBarsData = [];
          for (var entry in expenseSpots.entries) {
            lineBarsData.add(
              LineChartBarData(
                spots: entry.value,
                isCurved: true,
                color: colors[colorIndex % colors.length],
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
            );
            colorIndex++;
          }

          // Generate period names for x-axis
          List<String> periodNames = [];
          for (var data in sortedDataList) {
            final monthName = DateFormat('MMM yyyy').format(DateTime(data.year ?? 0, data.month ?? 1));
            periodNames.add(monthName);
          }

          return LineChart(
            LineChartData(
              lineBarsData: lineBarsData,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < periodNames.length) {
                        return Transform.rotate(
                          angle: -0.5,
                          child: Text(
                            periodNames[index],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Transform.rotate(
                        angle: -0.5,
                        child: Text(
                          AppFunction.formatRupiah(currency: value),
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: false,
                horizontalInterval: 10000,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.5),
                    strokeWidth: 1,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}