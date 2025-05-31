import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:report_sarang/env/extension/app_function.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/models/financial_model.dart';
// import 'package:report_sarang/src/dashboard/widgets/section_widget.dart';

class FinancialReportView extends StatefulWidget {
  const FinancialReportView({super.key});

  @override
  State<FinancialReportView> createState() => _FinancialReportViewState();
}

class _FinancialReportViewState extends State<FinancialReportView> {
  // Declare variables as instance fields, not local to build
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  final double width = 7;

  // Properly override initState at the class level
  @override
  void initState() {
    super.initState();
    // Initialize the bar groups
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  // Helper method to create BarChartGroupData
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.yellow,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.red,
          width: width,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // var finanCubit = context.read<FinancialCubit>();

    // final List<String> tableHeaders = [
    //   'Category',
    //   'Amount',
    // ];

    // final List<OtherCost> otherCost = [
    //   OtherCost(
    //     categoryName: 'Biaya Listrik',
    //     amount: 5000000,
    //   ),
    //   OtherCost(
    //     categoryName: 'Biaya Gaji',
    //     amount: 10000000,
    //   ),
    // ];

    return BlocBuilder<FinancialCubit, FinancialState>(
      builder: (context, state) {
        return SizedBox();
        // SingleChildScrollView(
        //     child: buildFinancialCard(context, finanCubit.financialModels, finanCubit, otherCost, tableHeaders, showingBarGroups),
        //   );
        // if (state is FinancialLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // } else if (state is FinancialSuccess) {
        //   return SingleChildScrollView(
        //     child: buildFinancialCard(context, finanCubit.financialModels, finanCubit),
        //   );
        // } else if (state is FinancialError) {
        //   return Center(child: Text(state.message));
        // } else {
        //   return const Center(child: Text('Please load the data'));
        // }
      },
    );
  }

  Widget buildFinancialCard(BuildContext context, FinancialModel model, FinancialCubit finanCubit, List<String> tableHeaders, List<BarChartGroupData> showingBarGroups) {
    
    int touchedGroupIndex = -1;

    // final dateFormat = DateFormat('dd/MM/yyyy');
    // String startDateStr = model.startDate != null ? dateFormat.format(model.startDate!) : '';
    // String endDateStr = model.endDate != null ? dateFormat.format(model.endDate!) : '';

    return Card(
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
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // AppFunction.formatRupiah(currency: double.parse(model.grandTotalCost?.toStringAsFixed(2) ?? '0.00')), 
                      AppFunction.formatRupiah(currency: double.parse('15000000.00')), 
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward, 
                          color: Colors.green
                        ),
                        SizedBox(width: 4),
                        Text(
                          '+2.3%', 
                          style: GoogleFonts.outfit(
                            color: Colors.green, 
                            fontSize: 16
                          )
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            
            // Summary Info
            // summaryInfo(
            //   'Cost Type', 
            //   'Production'
            // ),
            // summaryInfo(
            //   'Date Range', 
            //   '19/05/2025 - 20/05/2025'
            // ),
            // summaryInfo(
            //   'Branch', 
            //   'Cabang A'
            // ),
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
                    overflow: TextOverflow.ellipsis, // Prevents overflow if text is too long
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
                    '19/05/2025 - 20/05/2025',
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
              style: GoogleFonts.outfit(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 8),

            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
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
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold
                                )
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
                //           )),
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
                //   ),
                // ),
              ],
            ),

            BarChart(
              BarChartData(
                maxY: 20,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: ((group) {
                      return Colors.grey;
                    }),
                    getTooltipItem: (a, b, c, d) => null,
                  ),
                  touchCallback: (FlTouchEvent event, response) {
                    if (response == null || response.spot == null) {
                      setState(() {
                        touchedGroupIndex = -1;
                        showingBarGroups = List.of(rawBarGroups);
                      });
                      return;
                    }

                    touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                    setState(() {
                      if (!event.isInterestedForInteractions) {
                        touchedGroupIndex = -1;
                        showingBarGroups = List.of(rawBarGroups);
                        return;
                      }
                      showingBarGroups = List.of(rawBarGroups);
                      if (touchedGroupIndex != -1) {
                        var sum = 0.0;
                        for (final rod
                            in showingBarGroups[touchedGroupIndex].barRods) {
                          sum += rod.toY;
                        }
                        final avg = sum /
                            showingBarGroups[touchedGroupIndex]
                                .barRods
                                .length;

                        showingBarGroups[touchedGroupIndex] =
                            showingBarGroups[touchedGroupIndex].copyWith(
                          barRods: showingBarGroups[touchedGroupIndex]
                              .barRods
                              .map((rod) {
                            return rod.copyWith(
                                toY: avg, color: Colors.orange);
                          }).toList(),
                        );
                      }
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
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
                      interval: 1,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: showingBarGroups,
                gridData: const FlGridData(show: false),
              ),
              duration: Duration(milliseconds: 150), // Optional
              curve: Curves.linear, // Optional
            ),
          ],
        ),
      )
    );
  }
}

Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      meta: meta,
      space: 16, //margin top
      child: text,
    );
  }

Widget summaryInfo(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label      : ',
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}