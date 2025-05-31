import 'dart:developer';

import 'package:report_sarang/src/dashboard/models/batch_model.dart';
import 'package:report_sarang/src/dashboard/models/global_model.dart';
import 'package:report_sarang/src/dashboard/models/location_model.dart';
import 'package:report_sarang/src/dashboard/models/menu_model.dart';
import 'package:report_sarang/src/profile/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  int selectedIndex = 0;

  String? selectedBatchId;
  String? selectedSiteId;
  
  String? batchId = '';
  String batchName = '';
  
  String? locationId = '';
  String locationName = '';

  String? userName;
  String? userEmail;
  
  late List<Datum> batchList;
  late List<LocationModel> locationList;

  // Global model instance to store user and batch info
  GlobalModel globalModel = GlobalModel(
    email: '',
    id: '',
    fullName: '',
    siteId: '',
    batchId: '',
    permissions: [],
    photoUrl: '',
  );

  void onItemTapped(int index) async {
    emit(DashboardOnLoading());
    selectedIndex = index;
    emit(DashboardOnSuccess());
  }

  
  void loadMenu() {
    final menuItems = [
      MenuItem(
        title: 'Panen Telur',
        subtitle: 'Menghitung jumlah panen telur',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Eggs.png',
        backgroundColor: 0xFFFFF8D9,
      ),
      MenuItem(
        title: 'Panen Ayam',
        subtitle: 'Menghitung jumlah panen ayam',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/65/Chicken.png',
        backgroundColor: 0xFFFFDEBF,
      ),
      MenuItem(
        title: 'Cek Ayam',
        subtitle: 'Pengecekan kondisi ayam',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/3/32/Farmer_chicken.png',
        backgroundColor: 0xFFD9FFDB,
      ),
    ];
    emit(DashboardMenuSuccess(menuList: menuItems));
  }
  
  Future detailUser() async {
    emit(DashboardOnLoading());
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      final batchResponse = await AppApi.get(
        path: '/v1/batch',
        param: {
          'page': 1,
          'limit': 1000,
        },
      );

      final permissionsResponse = await AppApi.get(
        path: '/v1/auth/profile'
      );

      // Ambil data user dari API
      User rawData = await AppApi.getCurrentUser();
      // log('Detail User: ${rawData.email.toString()}', name: 'DashboardCubit');

      // Ambil data user untuk header
      userName = rawData.fullName ?? 'Unknown';
      userEmail = rawData.email ?? 'No email available';

      // Ambil hanya nama dan ID dari lokasi
      List<LocationModel> locations = rawData.sites
      .where((element) => element.site?.deletedAt == null)
      .map((element) {
        final site = element.site!;
        return LocationModel(
          id: site.id.toString(),
          name: site.name.toString(),
        );
      }).toList();

      if (batchResponse.data['status'] == 200) {
        var batchData = batchResponse.data['data']?['data'] as List? ?? [];
        var rolesData = permissionsResponse.data['data']['roles'] as List? ?? [];

        List<String> permissions = rolesData
            .expand((role) => (role['role']['permissions'] as List)
            .map((permission) => permission['permission']['code'].toString()))
            .toList();

        List<Datum> batch = batchData.map((item) => Datum.fromJson(item)).toList();

        // Update Global Model
        globalModel = globalModel.copyWith(
          email: userEmail,
          id: rawData.id,
          fullName: userName,
          siteId: prefs.getString('siteId'),
          batchId: batchId,
          permissions: permissions,
          photoUrl: permissionsResponse.data['data']['photoProfile'],
        );

        selectedSiteId = prefs.getString('siteId');

        try {
          locationName = locations.firstWhere(
            (location) => location.id == selectedSiteId,
            orElse: () => LocationModel(id: '', name: 'Unknown'),
          ).name;
        } catch (e) {
          return null;
        }

        batchList = batch;
        locationList = locations;

        emit(DashboardOnSuccess());
      } else {
        emit(DashboardOnFailed(message: 'Data batch not found'));
      }
    } catch (e) {
      log('Error occurred: $e', name: 'DashboardCubit');
      emit(DashboardOnFailed(message: 'Failed to load user details.'));
    }
  }

   // Function to update global model dynamically
  Future<void> updateGlobalModel({String? email, String? fullName, String? siteId, String? batchId}) async {
    emit(DashboardOnLoading());
    if (siteId != null) selectedSiteId = siteId;
    if (batchId != null) selectedBatchId = batchId;
    
    globalModel = globalModel.copyWith(
      email: email ?? globalModel.email,
      fullName: fullName ?? globalModel.fullName,
      siteId: siteId ?? globalModel.siteId,
      batchId: batchId ?? globalModel.batchId,
    );

    // jika siteId di update
    if (siteId != null) {
      selectedBatchId = null;
      globalModel = globalModel.copyWith(batchId: '');

      final switchResponse = await AppApi.post(
          path: '/v1/auth/switch',
          formdata: {
            'siteId': siteId,
          }
      );

      if (switchResponse.data['status'] != 200) {
        emit(DashboardOnFailed(message: 'Failed to switch site'));
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final accessToken = switchResponse.data['data']['token'];
      final username = prefs.getString('username') ?? '';
      final password = prefs.getString('password') ?? '';

      await AppApi.keepToken(
        token: accessToken,
        username: username,
        password: password,
        siteId: siteId,
      );
    }

    emit(DashboardOnLocationChanged());
    emit(DashboardOnSuccess());
  }

}
