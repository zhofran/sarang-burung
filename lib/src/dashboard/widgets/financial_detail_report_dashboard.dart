import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:report_sarang/env/extension/app_function.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/models/financial_model.dart';

class FinancialDetailReportView extends StatelessWidget {
  const FinancialDetailReportView({super.key});

  @override
  Widget build(BuildContext context) {
    var finanCubit = context.read<FinancialCubit>();

    // final otherCost = [
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
          return SingleChildScrollView(
            child: buildFinancialCard(context, finanCubit.financialModels, finanCubit),
          );
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

  Widget buildFinancialCard(BuildContext context, FinancialModel? model, FinancialCubit finanCubit) {
    // final dateFormat = DateFormat('dd/MM/yyyy');
    // String startDateStr = model.startDate != null ? dateFormat.format(model.startDate!) : '';
    // String endDateStr = model.endDate != null ? dateFormat.format(model.endDate!) : '';

    return Card(
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Financial Detail Summary',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
        
            // Summary Info
            Text(
              'Cost Type: Production',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Date Range: 19/05/2025 - 20/05/2025',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Branch: Cabang A',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
        
            // Main Costs
            Text(
              'Summary Details:',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description: Pembelian Bahan Baku Batch BCTH-001',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Amount: ${AppFunction.formatRupiah(currency: double.parse('50000000.00'))}',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Transaction Date: 20/05/2025',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
        
            // Other Costs
            // Text(
            //   'Other Costs:',
            //   style: GoogleFonts.outfit(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 8),
            // if (finanCubit.otherCosts.isNotEmpty)
            //   SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: DataTable(
            //       columns: const [
            //         DataColumn(label: Text('Category')),
            //         DataColumn(label: Text('Amount')),
            //       ],
            //       rows: finanCubit.otherCosts.map((cost) => DataRow(
            //         cells: [
            //           DataCell(Text(cost.categoryName ?? 'N/A')),
            //           DataCell(
            //             Text(
            //               AppFunction.formatRupiah(currency: double.parse(cost.amount?.toStringAsFixed(2) ?? '0.00'))
            //             )
            //           ),
            //         ],
            //       )).toList(),
            //     ),
            //   )
            // else
            //   const Text('No other costs'),
          ],
        ),
      ),
    );
  }
}