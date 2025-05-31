import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_card.dart';
import 'package:report_sarang/src/dashboard/cubit/cage_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/cctv_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hls_player.dart';

class CCTVPlayerDashboard extends StatelessWidget {
  const CCTVPlayerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          BlocBuilder<CCTVCubit, CCTVState>(
            builder: (context, state) {
              if (state is CCTVLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6, // Tinggi video
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.models.length,
                    itemBuilder: (context, index) {
                      final e = state.models[index];
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.85,// Lebar video
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${e.name} - ${e.description}',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: HlsPlayerWidget(
                                url: e.ipAddress,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is CCTVLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CCTVError) {
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
          'Live CCTV Kandang',
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
          context.select((CCTVCubit cubit) => cubit.selectedCageId);

          if(selectedCageId == null && cageState.cages.isNotEmpty) {
            context.read<CCTVCubit>().updateSelectedCage(cageState.cages.first.id);
          }

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
                context.read<CCTVCubit>().updateSelectedCage(value);
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
