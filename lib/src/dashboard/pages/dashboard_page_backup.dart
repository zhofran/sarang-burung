import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/location_batch_cubit.dart';
import 'package:report_sarang/src/dashboard/models/location_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:report_sarang/src/dashboard/cubit/dashboard_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  LocationModel? selectedLocation;
  // Batch? selectedBatch;

  @override
  void initState() {
    super.initState();
    context.read<LocationBatchCubit>().fetchLocationBatchData();
    context.read<DashboardCubit>().loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    // var my = AppShortcut.of(context);
    // varible to access cubit
    // var dashboardCubit = context.watch<DashboardCubit>();
    // var locationBatchCubit = context.watch<LocationBatchCubit>();
    
    return Scaffold(
      body: SizedBox(
        // color: Colors.amber,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<LocationBatchCubit, LocationBatchState>(
                builder: (_, state) {
                  if (state is LocationBatchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LocationBatchLoaded) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Dropdown untuk Lokasi
                            Expanded(
                              child: DropdownButton2<LocationModel>(
                                value: selectedLocation,
                                hint: Text(
                                  'Select Location',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                  ),
                                ),
                                isExpanded: true,
                                items: state.locations.map((location) {
                                  return DropdownMenuItem<LocationModel>(
                                    value: location,
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on, color: Colors.green),
                                        SizedBox(width: 8),
                                        Text(location.name),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedLocation = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            // Dropdown untuk Batch
                            // Expanded(
                            //   child: DropdownButton<Batch>(
                            //     value: selectedBatch,
                            //     hint: Text('Select Batch'),
                            //     isExpanded: true,
                            //     items: state.batches.map((batch) {
                            //       return DropdownMenuItem<Batch>(
                            //         value: batch,
                            //         child: Text(batch.name),
                            //       );
                            //     }).toList(),
                            //     onChanged: (value) {
                            //       setState(() {
                            //         selectedBatch = value;
                            //       });
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Garis bawah
                        Divider(
                          color: Colors.green,
                          thickness: 1.0,
                        ),
                      ],
                    );
                  } else if (state is LocationBatchError) {
                    return Center(
                      child: Text(state.message, style: TextStyle(color: Colors.red)),
                    );
                  }
                  return Container();
                },
              ),
              Expanded(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (_, state) {
                    if (state is DashboardMenuSuccess) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.menuList.length,
                        itemBuilder: (context, index) {
                          final menuItem = state.menuList[index];
                          debugPrint(menuItem.title); 
                          return AppCard(
                            backgroundColor: Colors.green,
                            child: InkWell(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'menuItem.title',
                                          style: GoogleFonts.outfit(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'menuItem.subtitle',
                                          style: GoogleFonts.outfit(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          );
                        }
                      );
                    }
                
                    return const SizedBox();
                  }
                ),
              )
            ],
          ),
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       // color: Colors.blue,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: 
                
        //         // Column(
        //         //   children: [
        //         //     Row(
        //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         //       children: [
        //         //         // Dropdown untuk Lokasi
        //         //         Expanded(
        //         //           child: DropdownButton<Location>(
        //         //             value: selectedLocation,
        //         //             hint: Text('Select Location'),
        //         //             isExpanded: true,
        //         //             items: state.locations.map((location) {
        //         //               return DropdownMenuItem<Location>(
        //         //                 value: location,
        //         //                 child: Row(
        //         //                   children: [
        //         //                     Icon(Icons.location_on, color: Colors.green),
        //         //                     SizedBox(width: 8),
        //         //                     Text(location.name),
        //         //                   ],
        //         //                 ),
        //         //               );
        //         //             }).toList(),
        //         //             onChanged: (value) {
        //         //               setState(() {
        //         //                 selectedLocation = value;
        //         //               });
        //         //             },
        //         //           ),
        //         //         ),
        //         //         SizedBox(width: 16),
        //         //         // Dropdown untuk Batch
        //         //         Expanded(
        //         //           child: DropdownButton<Batch>(
        //         //             value: selectedBatch,
        //         //             hint: Text('Select Batch'),
        //         //             isExpanded: true,
        //         //             items: state.batches.map((batch) {
        //         //               return DropdownMenuItem<Batch>(
        //         //                 value: batch,
        //         //                 child: Text(batch.name),
        //         //               );
        //         //             }).toList(),
        //         //             onChanged: (value) {
        //         //               setState(() {
        //         //                 selectedBatch = value;
        //         //               });
        //         //             },
        //         //           ),
        //         //         ),
        //         //       ],
        //         //     ),
        //         //     SizedBox(height: 8),
        //         //     // Garis bawah
        //         //     Divider(
        //         //       color: Colors.green,
        //         //       thickness: 1.0,
        //         //     ),
        //         //   ],
        //         // )
        //         // Column(
        //         //   children: [
        //         //     Row(
        //         //       // crossAxisAlignment: CrossAxisAlignment.start,
        //         //       children: [
        //         //         Icon(
        //         //           Icons.location_on,
        //         //           color: Colors.green,
        //         //         ),
        //         //         Container(
        //         //           width: 155,
        //         //           child: DropdownButton2(
        //         //             items: dropdownItems.map((item) {
        //         //               return DropdownMenuItem<String>(
        //         //                 value: item['value'],
        //         //                 child: Row(
        //         //                   children: [
        //         //                     Text(item['value']),
        //         //                   ],
        //         //                 ),
        //         //               );
        //         //             }).toList(),
        //         //             onChanged: (value) {
        //         //               setState(() {
        //         //                 selectedItem = value; // Update item yang dipilih
        //         //               });
        //         //             },
        //         //           ),
        //         //         )
        //         //         // DropdownButton<String>(
        //         //         //   value: selectedItem,
        //         //         //   hint: Text('Select an option'),
        //         //         //   icon: Icon(Icons.arrow_drop_down), // Ikon dropdown di sebelah kanan
        //         //         //   iconSize: 24,
        //         //         //   // underline: Container(
        //         //         //   //   height: 2,
        //         //         //   //   color: Colors.green, // Warna garis bawah dropdown
        //         //         //   // ),
        //         //         //   items: dropdownItems.map((item) {
        //         //         //     return DropdownMenuItem<String>(
        //         //         //       value: item['value'],
        //         //         //       child: Row(
        //         //         //         children: [
        //         //         //           Icon(item['icon'], color: Colors.green), // Ikon di item
        //         //         //           SizedBox(width: 10), // Jarak antara ikon dan teks
        //         //         //           Text(item['value']),
        //         //         //         ],
        //         //         //       ),
        //         //         //     );
        //         //         //   }).toList(),
        //         //         //   onChanged: (value) {
        //         //         //     setState(() {
        //         //         //       selectedItem = value; // Update item yang dipilih
        //         //         //     });
        //         //         //   },
        //         //         // ),
        //         //       ],
        //         //     ),
        //         //     Divider(
        //         //       color: Colors.green,
        //         //     )
        //         //   ],
        //         // ),
        //       ),
        //     )
        //   ],
        // ),
      ) 
      // IndexedStack(
      //   index: dashboardCubit.selectedIndex,
      //   children: pages,
      // ),
      // bottomNavigationBar: Material(
      //   elevation: 100,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       BottomNavigationBar(
      //         elevation: 5,
      //         type: BottomNavigationBarType.fixed,
      //         selectedFontSize: 12,
      //         unselectedFontSize: 12,
      //         showSelectedLabels: true,
      //         showUnselectedLabels: true,
      //         selectedItemColor: my.color.primary,
      //         unselectedItemColor: AppConstant.grey,
      //         selectedLabelStyle: const TextStyle(
      //           fontWeight: FontWeight.w600,
      //         ),
      //         unselectedLabelStyle: const TextStyle(
      //           fontWeight: FontWeight.w600,
      //         ),
      //         items: List.generate(
      //           2,
      //           (x) => BottomNavigationBarItem(
      //             icon: IconImage(
      //               icon: icons[x],
      //               color: dashboardCubit.selectedIndex == x
      //                   ? my.color.primary
      //                   : AppConstant.grey,
      //             ),
      //             label: titles[x],
      //           ),
      //         ),
      //         currentIndex: dashboardCubit.selectedIndex,
      //         onTap: dashboardCubit.onItemTapped,
      //       ),
      //       Platform.isIOS ? const SizedBox(height: 16) : const SizedBox(),
      //     ],
      //   ),
      // ),
    );
  }
}
