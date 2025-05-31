import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:report_sarang/env/extension/app_function.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/models/financial_model.dart';
import 'dart:math';

class FinancialReportView extends StatefulWidget {
  const FinancialReportView({super.key});

  @override
  State<FinancialReportView> createState() => _FinancialReportViewState();
}

class _FinancialReportViewState extends State<FinancialReportView> {
  final double width = 7;

  @override
  Widget build(BuildContext context) {
    var finanCubit = context.read<FinancialCubit>();

    final List<String> tableHeaders = [
      'Category',
      'Amount',
    ];

    // final List<OtherCost> otherCost = [
    //   OtherCost(categoryName: 'Biaya Listrik', amount: 5000000),
    //   OtherCost(categoryName: 'Biaya Gaji', amount: 10000000),
    // ];

    return BlocBuilder<FinancialCubit, FinancialState>(
      builder: (context, state) {
        if (state is FinancialLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FinancialSuccess) {
          return buildFinancialCard(context, finanCubit.financialModels, finanCubit, tableHeaders);
        } else if (state is FinancialError) {
          return Center(child: Text(state.message));
        } else {
          // For the current state or initial state, use financialModels as a fallback
          // return buildFinancialCard(context, finanCubit.financialModels, finanCubit, otherCost, tableHeaders);
          return Center(child: Text('No financial data available.'));
        }
      },
    );
  }

  Widget buildFinancialCard(BuildContext context, FinancialModel? model, FinancialCubit finanCubit, List<String> tableHeaders) {
    // final dateFormat = DateFormat('dd/MM/yyyy');
    // String startDateStr = model.startDate != null ? dateFormat.format(model.startDate!) : '';
    // String endDateStr = model.endDate != null ? dateFormat.format(model.endDate!) : '';

    // Dummy daily costs data (replace with actual data from model)
    final dailyCosts = [
      {'production': 5000000.0, 'other': 2000000.0},
      {'production': 6000000.0, 'other': 3000000.0},
      {'production': 7000000.0, 'other': 2500000.0},
      {'production': 8000000.0, 'other': 4000000.0},
      {'production': 5500000.0, 'other': 3500000.0},
      {'production': 9000000.0, 'other': 4500000.0},
      {'production': 10000000.0, 'other': 5000000.0},
    ];

    // Calculate maxY dynamically
    double maxCost = 0;
    for (var cost in dailyCosts) {
      maxCost = max(maxCost, cost['production']! / 1000000);
      maxCost = max(maxCost, cost['other']! / 1000000);
    }
    double maxY = (maxCost.ceilToDouble() * 1.2).toDouble();

    // Generate bar groups dynamically
    List<BarChartGroupData> generateBarGroups() {
      return List.generate(7, (index) {
        final production = dailyCosts[index]['production']! / 1000000;
        final other = dailyCosts[index]['other']! / 1000000;
        return makeGroupData(index, production, other);
      });
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
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
                        AppFunction.formatRupiah(currency: 15000000.00),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.arrow_upward, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            '+2.3%',
                            style: GoogleFonts.outfit(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                    'Cost Type     : ',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Production',
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
                    'Date Range : ',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // '$startDateStr - $endDateStr',
                      '01/01/2023 - 07/01/2023',
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
                    'Branch           : ',
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
              const SizedBox(height: 16),
              Text(
                'Other Costs',
                style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    children: tableHeaders
                        .map((header) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  header,
                                  style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  // ...otherCosts.map((row) => TableRow(
                  //     decoration: BoxDecoration(color: Colors.grey[200]),
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text(
                  //           row.categoryName ?? 'N/A',
                  //           style: GoogleFonts.outfit(
                  //             fontSize: 14,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Center(
                  //           child: Text(
                  //             AppFunction.formatRupiah(currency: double.parse(row.amount?.toStringAsFixed(2) ?? '0.00')),
                  //             style: GoogleFonts.outfit(
                  //               fontSize: 14,
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   )
                  // ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container( 
                        width: 16,
                        height: 16,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Production Cost',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container( 
                        width: 16,
                        height: 16,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Operational Cost',
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
              Expanded( // Wrap BarChart in Expanded to take remaining space
                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => Colors.grey,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          if (rodIndex == 0) {
                            final productionCost = group.barRods[0].toY * 1000000;
                            final otherCost = group.barRods[1].toY * 1000000;
                            return BarTooltipItem(
                              'Production: ${AppFunction.formatRupiah(currency: productionCost)}\n'
                              'Operational: ${AppFunction.formatRupiah(currency: otherCost)}',
                              const TextStyle(color: Colors.white, fontSize: 14),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: maxY / 5,
                          getTitlesWidget: (value, meta) {
                            if (value % (maxY / 5) == 0) {
                              return Text(
                                '${value.toStringAsFixed(1)}M',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: generateBarGroups(),
                    gridData: const FlGridData(show: false),
                  ),
                  duration: Duration(milliseconds: 150),
                  curve: Curves.linear,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: Colors.yellow, width: width),
        BarChartRodData(toY: y2, color: Colors.red, width: width),
      ],
    );
  }
}

Widget bottomTitles(double value, TitleMeta meta) {
  final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];
  return SideTitleWidget(
    space: 16,
    meta: meta,
    child: Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  );
}