// ignore_for_file: non_constant_identifier_names

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/dashboard_cubit.dart';
// import 'package:report_sarang/src/dashboard/widgets/financial_report_dashboard.dart';
import 'package:report_sarang/src/dashboard/widgets/financial_summary_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/financial_detail_report_dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Panen Telur',
      'subtitle': 'Menghitung jumlah panen telur',
      'imageUrl': AppAsset.eggsPic,
      'backgroundColor': 0xFFFFF8D9,
      'route': AppRoute.reportPage.path
    },
    {
      'title': 'Panen Ayam',
      'subtitle': 'Menghitung jumlah panen ayam',
      'imageUrl': AppAsset.chickenPic,
      'backgroundColor': 0xFFFFDEBF,
      // 'route': AppRoute.panenAyamPage.path
    },
    {
      'title': 'Cek Ayam',
      'subtitle': 'Pengecekan kondisi ayam',
      'imageUrl': AppAsset.farmerPic,
      'backgroundColor': 0xFFD9FFDB,
      // 'route': AppRoute.cekAyamPage.path
    },
  ];

  void onRefresh() {
    context.read<FinancialCubit>().fetchYearlyExpenses();
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    // var dashCubit = context.watch<DashboardCubit>();

    final List<String> period_type = [
      'weekly',
      'monthly',
      'yearly',
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          onRefresh();
          return Future.value();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report Summary',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('US', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  BlocListener<DashboardCubit, DashboardState>(
                    listener: (_, state) {
                      if (state is DashboardOnFailed) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text(state.message)),
                        // );
                      }
                      if(state is DashboardOnLocationChanged){
                        onRefresh();
                      }
                    },
                    child: BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (_, state) {
                        if (state is DashboardOnLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/images/loading.json'),
                                Text(
                                  'Memuat data, mohon tunggu...',
                                  style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      color: Color(0xFF0F6646),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        }
                        return SizedBox(
                          child: Text(
                            // 'Data not found',
                            '',
                            style: GoogleFonts.outfit(
                                fontSize: 16,
                                color: Color(0xFF0F6646),
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                    ),
                  ),
                  // Divider(color: Colors.green, thickness: 1.0),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // FinancialReportView(),
                  // SizedBox(height: 10),

                  FinancialSummaryDashboard( 
                    period_type: period_type,
                  ),
                  SizedBox(height: 10),

                  // FinancialDetailReportView(),
                  // SizedBox(height: 10),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
