import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_button.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/lamp_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorLampDashboard extends StatelessWidget {
  const SensorLampDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          BlocBuilder<LampCubit, LampState>(
            builder: (context, state) {
              if (state is LampLoaded) {
                return SizedBox(
                  height: 200, // Tinggi video
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.models.length,
                    itemBuilder: (context, index) {
                      final e = state.models[index];

                      return Container(
                          width: MediaQuery.of(context).size.width * 0.85, // Lebar video
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${e.iotSensor?.name?.replaceAll("Sensor", "Lampu")}',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            AppButton(
                                label: AppParse.isSensorAlive(e) ? 'Hidup' : 'Mati',
                                onTap: ()=>{},
                              padding: 10,
                              backgroundColor: AppParse.isSensorAlive(e) ? Colors.green : Colors.red,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is LampLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LampError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sensor Lampu',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppConstant.black,
          ),
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
          context.select((LampCubit cubit) => cubit.selectedCageId);

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
                context.read<LampCubit>().updateSelectedCage(value);
              }
            },
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppConstant.black,
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
