import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:report_sarang/env/extension/app_function.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
// import 'package:report_sarang/src/dashboard/models/financial_model.dart';

class FinancialTable extends StatelessWidget {
  const FinancialTable({super.key});

  @override
  Widget build(BuildContext context) {
    // var financialCubit = context.watch<FinancialCubit>();

    return BlocBuilder<FinancialCubit, FinancialState>(
      builder: (context, state) {
        return Card(
          child: Column(
            children: [
              // Title of the report
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Financial Report',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Header section
              _buildHeader(),

              // Scrollable table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Amount'), numeric: true),
                  ],
                  rows: [
                    // Production Cost row
                    // ...financialCubit.financialModels
                    //     .map((cost) => DataRow(cells: [
                    //           DataCell(Text('Total Production Cost')),
                    //           DataCell(Text(
                    //             AppFunction.formatRupiah(
                    //                 currency: double.parse(
                    //                     cost.totalProductionCost.toString())),
                    //           )),
                    //         ])),

                    // DataRow(cells: [
                    //   const DataCell(Text('Production Cost')),
                    //   DataCell(Text(formatCurrency(financialCubit.financialModels.totalProductionCost))),
                    // ]),

                    // Operational Cost row
                    // DataRow(cells: [
                    //   const DataCell(Text('Operational Cost')),
                    //   DataCell(Text(formatCurrency(model.totalOperationalCost))),
                    // ]),

                    // Other Costs rows
                    // ...model.otherCosts.map((cost) => DataRow(cells: [
                    //       DataCell(Text(cost.categoryName ?? 'Unknown')),
                    //       DataCell(Text(formatCurrency(cost.amount))),
                    //     ])),

                    // Grand Total row (bold styling)
                    // DataRow(cells: [
                    //   const DataCell(Text(
                    //     'Grand Total',
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   )),
                    //   DataCell(Text(
                    //     formatCurrency(model.grandTotalCost),
                    //     style: const TextStyle(fontWeight: FontWeight.bold),
                    //   )),
                    // ]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Builds the header with period type, dates, and branch
  Widget _buildHeader() {
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
              DateFormat('MMMM yyyy').format(DateTime.now()),
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
}
