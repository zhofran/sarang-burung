// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:report_sarang/env/extension/app_function.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/models/financial_year_model.dart';

class FinancialSummaryDashboard extends StatefulWidget {
  final List<String> period_type;

  const FinancialSummaryDashboard({super.key, required this.period_type});

  @override
  State<FinancialSummaryDashboard> createState() => _FinancialSummaryDashboardState();
}

class _FinancialSummaryDashboardState extends State<FinancialSummaryDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<FinancialCubit>().fetchYearlyExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final finanCubit = context.watch<FinancialCubit>();

    return BlocListener<FinancialCubit, FinancialState>(
      listener: (context, state) {
        log('FinancialSummary state: $state');
        if (state is FinancialError) {
          log('FinancialSummary error: ${state.message}');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
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
        ],
      ),
    );
  }

  /// **HEADER** - Displays title, year, and total expenses
  Widget _buildHeader(BuildContext context, FinancialCubit finanCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Symbols.finance, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Financial Summary',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppFunction.formatRupiah(currency: double.parse(finanCubit.financialYearData!.fullGrandTotal.toString())),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Row(
                //   children: [
                //     Icon(Icons.arrow_upward, color: Colors.green),
                //     SizedBox(width: 4),
                //     Text(
                //       '+2.3%',
                //       style: GoogleFonts.outfit(
                //         color: Colors.green,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 
              'Year                       : ',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Text(
                finanCubit.year,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Expenses : ',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Text(
                AppFunction.formatRupiah(currency: double.parse(finanCubit.financialYearData!.fullGrandTotal.toString())),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Branch                 : ',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Text(
                'Cabang A',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// **LINE CHART** - Displays expense data over months
  Widget _buildLineChart(BuildContext context, FinancialCubit finanCubit) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: BlocBuilder<FinancialCubit, FinancialState>(
        builder: (context, state) {
          if (state is FinancialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FinancialSuccess) {
            final dataList = finanCubit.fullData;
            if (dataList.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            final year = int.tryParse(finanCubit.financialYearData?.year ?? '0') ?? 0;
            final sortedDataList = List<FullData>.from(dataList)
              ..sort((a, b) => (a.month ?? 0).compareTo(b.month ?? 0));

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
                  orElse: () => ExpenseYear(name: expenseName, amount: '0'),
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
            Map<String, Color> expenseColors = {};
            for (var entry in expenseSpots.entries) {
              final color = colors[colorIndex % colors.length];
              lineBarsData.add(
                LineChartBarData(
                  spots: entry.value,
                  isCurved: true,
                  color: color,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              );
              expenseColors[entry.key] = color;
              colorIndex++;
            }

            // Generate period names for x-axis
            List<String> periodNames = [];
            for (var data in sortedDataList) {
              final monthName = DateFormat('MMM yyyy').format(DateTime(year, data.month ?? 1));
              periodNames.add(monthName);
            }

            // Build legend
            List<Widget> legendItems = uniqueExpenses.map((expenseName) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: expenseColors[expenseName],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      expenseName,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: legendItems,
                  ),
                ),
                const SizedBox(height: 30.0),
                Expanded(
                  child: LineChart(
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
                  ),
                ),
              ],
            );
          } else if (state is FinancialError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}