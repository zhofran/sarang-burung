import 'dart:convert';
import 'dart:developer';

import 'package:report_sarang/env/extension/on_context.dart';
import 'package:report_sarang/src/dashboard/cubit/financial_cubit.dart';
import 'package:report_sarang/src/dashboard/cubit/location_batch_cubit.dart';
import 'package:report_sarang/src/dashboard/models/sensor_model.dart';
import 'package:report_sarang/src/login/cubit/visibility_cubit.dart';
import 'package:report_sarang/src/report/cubit/report_cubit.dart';
import 'package:report_sarang/src/report/pages/report_detail_page.dart';
import 'package:report_sarang/src/report/pages/report_page.dart';
import 'package:report_sarang/src/splash/cubit/splash_cubit.dart';
import 'package:report_sarang/src/splash/pages/splash_page.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_sarang/env/model/app_date_model.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/src/dashboard/cubit/dashboard_cubit.dart';
import 'package:report_sarang/src/dashboard/pages/dashboard_page.dart';
import 'package:report_sarang/src/login/cubit/login_cubit.dart';
import 'package:report_sarang/src/login/pages/login_page.dart';
import 'package:report_sarang/src/profile/models/user_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part '../enum/app_enum.dart';
part '../class/app_route.dart';
part '../class/app_parse.dart';
part '../model/app_model.dart';
part '../class/app_api.dart';
part '../class/app_assets.dart';

typedef Env = AppEnvironment;

class AppEnvironment {
  static Map<String, Widget Function(BuildContext)> routes = {
    for (AppRoute route in [
      AppRoute.splashPage,
      AppRoute.loginPage,
      AppRoute.dashboardPage,
      AppRoute.reportPage,
      AppRoute.reportDetailPage,
      // AppRoute.scannerPage,
      // AppRoute.panenAyamPage,
      // AppRoute.cekAyamPage,
      // AppRoute.panenDetailPage,
    ])
      route.path: (BuildContext context) => route.page
  };

  // default
  static String initialRoute = AppRoute.splashPage.path;
  static String dummyRoute = '';

  static AppScope scope = AppScope.external;
}
