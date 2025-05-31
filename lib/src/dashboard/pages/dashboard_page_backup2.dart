// ignore_for_file: non_constant_identifier_names

import 'package:report_sarang/env/class/app_env.dart';
// import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/amonia_cubit.dart';
// import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/cctv_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/chicken_chart_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/chicken_production_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/egg_production_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/humidity_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/lamp_cubit.dart';
// import 'package:report_sarang/src/dashboard/cubit/location_batch_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/log_sensor_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/temperature_cubit.dart';
// import 'package:report_sarang/src/dashboard/widgets/amonia_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/cctv_player_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/chicken_pie_chart.dart';
// import 'package:report_sarang/src/dashboard/widgets/chicken_production_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/egg_production_dashboard.dart';
import 'package:report_sarang/src/dashboard/widgets/financial_detail_report_dashboard.dart';
import 'package:report_sarang/src/dashboard/widgets/financial_report_dashboard.dart';
import 'package:report_sarang/src/dashboard/widgets/financial_summary_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/financial_table_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/humidity_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/lamp_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/log_sensor.dart';
// import 'package:report_sarang/src/dashboard/widgets/temperature_dashboard.dart';
// import 'package:report_sarang/src/dashboard/widgets/user_header_card.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:report_sarang/src/dashboard/cubit/dashboard_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final selectedLocation;

  // final locations = [
  //   LocationModel(id: '1', name: 'Majalengka'),
  //   LocationModel(id: '2', name: 'Bandung'),
  //   LocationModel(id: '3', name: 'Jakarta'),
  // ];

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
    // context.read<DashboardCubit>().detailUser();
    // context.read<LocationBatchCubit>().fetchLocationBatchData();

    // context.read<CageCubit>().go();

    // context.read<TemperatureCubit>().go();
    // context.read<AmoniaCubit>().go();
    // context.read<HumidityCubit>().go();
    // context.read<EggProductionCubit>().go();
    // context.read<ChickenProductionCubit>().go();
    // context.read<ChickenChartCubit>().go();
    // context.read<LampCubit>().go();
    // context.read<LogSensorCubit>().go();

    context.read<FinancialCubit>().go();
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
                        context.read<TemperatureCubit>().selectedCageId = null;
                        context.read<AmoniaCubit>().selectedCageId = null;
                        context.read<HumidityCubit>().selectedCageId = null;
                        context.read<EggProductionCubit>().selectedCageId = null;
                        context.read<ChickenProductionCubit>().selectedCageId = null;
                        context.read<ChickenChartCubit>().selectedCageId = null;
                        context.read<LampCubit>().selectedCageId = null;
                        context.read<LogSensorCubit>().selectedCageId = null;
                        context.read<CCTVCubit>().selectedCageId = null;

                        onRefresh();
                      }
                    },
                    child: BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (_, state) {
                        // if (state is DashboardOnSuccess) {
                        //   return Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       // Dropdown Lokasi
                        //       Expanded(
                        //         child: DropdownButton2<String>(
                        //           value: dashCubit.selectedSiteId,
                        //           hint: Text(
                        //             'Select Location',
                        //             style: GoogleFonts.outfit(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.black,
                        //             ),
                        //           ),
                        //           isExpanded: true,
                        //           items: dashCubit.locationList.isNotEmpty
                        //           ? dashCubit.locationList.map((location) {
                        //               return DropdownMenuItem<String>(
                        //                 value: location.id,
                        //                 child: Text(
                        //                   location.name,
                        //                   style: GoogleFonts.outfit(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w500,
                        //                     color: Colors.black,
                        //                   ),
                        //                 ),
                        //               );
                        //             }).toList()
                        //           : [],
                        //           onChanged: (value) {
                        //             if (value != null) {
                        //               dashCubit.selectedSiteId = value;
                        //               dashCubit.updateGlobalModel(
                        //                   siteId: value);
                        //             }
                        //           },
                        //           buttonStyleData: ButtonStyleData(
                        //             // height: 50,
                        //             padding: const EdgeInsets.only(right: 8),
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(30),
                        //               border: Border.all(
                        //                   width: 0, color: Colors.transparent),
                        //               // color: My.grey3,
                        //             ),
                        //           ),
                        //           iconStyleData: const IconStyleData(
                        //             icon: Icon(
                        //               Icons.arrow_drop_down,
                        //               color: Color(0xFF0F6646),
                        //             ),
                        //             iconSize: 24,
                        //           ),
                        //           dropdownStyleData: DropdownStyleData(
                        //             maxHeight: 200,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //             ),
                        //           ),
                        //           menuItemStyleData: const MenuItemStyleData(
                        //             padding:
                        //                 EdgeInsets.symmetric(horizontal: 16),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(width: 16),
                        //       // Dropdown Batch
                        //       Expanded(
                        //         child: DropdownButton2<String>(
                        //           value: dashCubit.selectedBatchId,
                        //           hint: Text(
                        //             'Select Batch',
                        //             style: GoogleFonts.outfit(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.black,
                        //             ),
                        //           ),
                        //           isExpanded: true,
                        //           items: dashCubit.batchList.isNotEmpty
                        //           ? dashCubit.batchList.map((batchItem) {
                        //               return DropdownMenuItem<String>(
                        //                 value: batchItem.id, // Pastikan id dalam bentuk String
                        //                 child: Text(
                        //                   batchItem.name ?? '',
                        //                   style: GoogleFonts.outfit(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w500,
                        //                     color: Colors.black,
                        //                   ),
                        //                 ),
                        //               );
                        //             }).toList()
                        //           :[],
                        //           onChanged: (value) {
                        //             if (value != null) {
                        //               dashCubit.selectedBatchId = value;
                        //               // selectedLocation =
                        //               //     dashCubit.locationList.firstWhere(
                        //               //   (item) => item.id == value,
                        //               //   orElse: () => LocationModel(
                        //               //       id: '', name: 'Unknown'),
                        //               // );

                        //               dashCubit.updateGlobalModel(
                        //                   batchId: value);
                        //             }
                        //           },
                        //           buttonStyleData: ButtonStyleData(
                        //             // height: 50,
                        //             padding: const EdgeInsets.only(right: 8),
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(30),
                        //               border: Border.all(
                        //                   width: 0, color: Colors.transparent),
                        //               // color: My.grey3,
                        //             ),
                        //           ),
                        //           iconStyleData: const IconStyleData(
                        //             icon: Icon(
                        //               Icons.arrow_drop_down,
                        //               color: Color(0xFF0F6646),
                        //             ),
                        //             iconSize: 24,
                        //           ),
                        //           dropdownStyleData: DropdownStyleData(
                        //             maxHeight: 200,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //             ),
                        //           ),
                        //           menuItemStyleData: const MenuItemStyleData(
                        //             padding:
                        //                 EdgeInsets.symmetric(horizontal: 16),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   );
                        // }

                        // if (state is DashboardOnLoading){
                        //   return Text(
                        //     'Loading...',
                        //     style: GoogleFonts.outfit(
                        //         fontSize: 16,
                        //         color: Color(0xFF0F6646),
                        //         fontWeight: FontWeight.w500),
                        //   );
                        // }

                        // if(state is DashboardOnFailed){
                        //   return SizedBox(
                        //     child: Text(
                        //       state.message,
                        //       style: GoogleFonts.outfit(
                        //           fontSize: 16,
                        //           color: Color(0xFF0F6646),
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   );
                        // }

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
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width * 1,
            //     height: 100,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: menuItems.length,
            //       itemBuilder: (context, index) {
            //         final item = menuItems[index];
            //         return Row(
            //           children: [
            //             AppCard(
            //               onTap: () {
            //                 // context.toNamed(
            //                 //   route: AppRoute.scannerPage.path,
            //                 //   arguments: {
            //                 //     'route': item['route'],
            //                 //   }
            //                 // );
            //               },
            //               backgroundColor: Color(item['backgroundColor']),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         item['title'],
            //                         style: GoogleFonts.outfit(
            //                           color: Colors.black,
            //                           fontSize: 20,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                       Text(
            //                         item['subtitle'],
            //                         style: GoogleFonts.outfit(
            //                           color: Colors.black,
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w500,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   Image.asset(
            //                     item['imageUrl'],
            //                     fit: BoxFit.cover,
            //                   )
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               width: 5,
            //             )
            //           ],
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // FinancialSummaryDashboard(period_type: period_type,),
                  // SizedBox(height: 10),

                  FinancialReportView(),
                  SizedBox(height: 10),

                  FinancialSummaryDashboard( 
                    period_type: period_type,
                  ),
                  SizedBox(height: 10),

                  FinancialDetailReportView(),
                  SizedBox(height: 10),
                ],
              )
              // BlocBuilder<DashboardCubit, DashboardState>(
              //   builder: (_, state){
              //     if(state is DashboardOnSuccess){
              //       return 
              //       Column(
              //         children: [
              //           // if(dashCubit.globalModel.hasPermission("show:dashboard-chicken-chart")) //
              //           //   ChickenPieChart(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:chart-egg"))
              //             FinancialSummaryDashboard(),
              //             SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:chart-chicken")) //
              //           //   ChickenProductionDashboard(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:temperature-sensors")) //
              //           //   TemperatureDashboard(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:amonia-sensors")) //
              //           //   AmoniaDashboard(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:humidity-sensors")) //
              //           //   HumidityDashboard(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:light-sensors")) //
              //           //   SensorLampDashboard(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:light-sensors")) //
              //           //   LogSensor(),
              //           //   SizedBox(height: 10),

              //           // if(dashCubit.globalModel.hasPermission("show:cctv-dashboard")) //
              //           //   CCTVPlayerDashboard(),
              //         ],
              //       );
              //     }

              //     if(state is DashboardOnLoading){
              //       return Center(child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Lottie.asset('assets/images/loading.json'),
              //           Text(
              //             'Memuat data, mohon tunggu...',
              //             style: GoogleFonts.outfit(
              //                 fontSize: 16,
              //                 color: Color(0xFF0F6646),
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ],
              //       ));
              //     }

              //     return SizedBox(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Lottie.asset('assets/images/no_data.json'),
              //           Text(
              //             state is DashboardOnFailed ? state.message : 'Data not found',
              //             style: GoogleFonts.outfit(
              //                 fontSize: 16,
              //                 color: Color(0xFF0F6646),
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
