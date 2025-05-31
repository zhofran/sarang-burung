part of '../class/app_env.dart';

class AppRoute {
  const AppRoute({required this.path, required this.page});
  final String path;
  final Widget page;

  static AppRoute splashPage = AppRoute(
      path: 'splashPage',
      page: BlocProvider(
        create: (_) => SplashCubit()..splash(),
        child: const SplashPage(),
      ));

  static AppRoute loginPage = AppRoute(
    path: 'loginPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => VisibilityCubit(),
        ),
      ],
      child: const LoginPage(),
    ),
  );

  static AppRoute dashboardPage = AppRoute(
      path: 'dashboardPage',
      page: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => DashboardCubit()),
        BlocProvider(create: (_) => LocationBatchCubit()),
        BlocProvider(create: (_) => FinancialCubit()),
        // BlocProvider(create: (_) => TemperatureCubit()),
        // BlocProvider(create: (_) => AmoniaCubit()),
        // BlocProvider(create: (_) => HumidityCubit()),
        // BlocProvider(create: (_) => CCTVCubit()),
        // BlocProvider(create: (_) => ChickenChartCubit()),
        // BlocProvider(create: (_) => LampCubit()),
        // BlocProvider(create: (_) => CageCubit()),
        // BlocProvider(create: (_) => EggProductionCubit()),
        // BlocProvider(create: (_) => ChickenProductionCubit()),
        // BlocProvider(create: (_) => LogSensorCubit())
      ], child: const DashboardPage()));

  static AppRoute reportPage = AppRoute(
      path: 'reportPage',
      page: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: ReportCubit(),
          ),
        ],
        child: Builder(
          builder: (context) {
            var args = context.modal<Map<String, dynamic>?>();

            context.read<ReportCubit>().fetchDataRak(uuid: args?['uuid']);

            return const Reportpage();
          },
        ),
      ));

  static AppRoute reportDetailPage = AppRoute(
      path: 'reportDetailPage',
      page: BlocProvider.value(
        // create: (_) => ReportCubit(),
        value: ReportCubit(),
        child: const ReportDetailPage(),
      ));

  // static AppRoute scannerPage = AppRoute(
  //     path: 'scannerPage',
  //     page: BlocProvider(
  //       create: (_) => ScannerCubit(),
  //       child: const ScannerPage(),
  //     ));

  // static AppRoute panenAyamPage = AppRoute(
  //     path: 'panenAyamPage',
  //     page: BlocProvider.value(
  //       value: AyamCubit(),
  //       child: Builder(
  //         builder: (context) {
  //           var args = context.modal<Map<String, dynamic>?>();

  //           context.read<AyamCubit>().fetchDataAyam(uuid: args?['uuid']);

  //           return const PanenAyamPage();
  //         },
  //       ),
  //     ));

  // static AppRoute cekAyamPage = AppRoute(
  //     path: 'cekAyamPage',
  //     page: BlocProvider.value(
  //       value: AyamCubit(),
  //       child: Builder(
  //         builder: (context) {
  //           var args = context.modal<Map<String, dynamic>?>();

  //           context.read<AyamCubit>().fetchDataAyam(uuid: args?['uuid']);

  //           return CekAyamPage();
  //         },
  //       ),
  //     ));

  // static AppRoute panenDetailPage = AppRoute(
  //     path: 'panenDetailPage',
  //     page: MultiBlocProvider(
  //       providers: [
  //         BlocProvider.value(
  //           // create: (_) => ReportCubit(),
  //           value: AyamCubit(),
  //         ),
  //         BlocProvider(
  //           create: (_) => ReportCubit(),
  //         ),
  //       ],
  //       child: const PanenDetailPage(),
  //     ));

  // example route without bloc provider
  // static AppRoute blankPage = const AppRoute(
  //   path: 'blankPage',
  //   page: BlankPage(),
  // );

  // example route single bloc provider
  // static AppRoute splashPage = AppRoute(
  //   path: 'splashPage',
  //   page: BlocProvider(
  //     create: (_) => SplashCubit()..splash(),
  //     child: const SplashPage(),
  //   ),
  // );

  // example route single bloc provider with builder (if need params)
  // static AppRoute otpPage = AppRoute(
  //   path: 'otpPage',
  //   page: BlocProvider(
  //     create: (context) => OtpCubit(),
  //     child: Builder(
  //       builder: (context) {
  //         var modal = context.modal<Map<String, dynamic>?>();
  //         if (modal?['isResend'] == true) {
  //           context.read<OtpCubit>().resendOtp(
  //                 numberPhone: modal?['numberPhone'],
  //               );
  //         }
  //         return const OtpPage();
  //       },
  //     ),
  //   ),
  // );

  // example route multi bloc provider
  // static AppRoute dashboardPage = AppRoute(
  //   path: 'dashboardPage',
  //   page: MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (_) => ProfileCubit()..getProfile()),
  //       BlocProvider(create: (_) => HomepageCubit()),
  //       BlocProvider(
  //           create: (_) => TransactionHistoryCubit()..getTransactionHistory()),
  //     ],
  //     child: const DashboardPage(),
  //   ),
  // );

  // example route single bloc provider with builder (if need params)
  // static AppRoute paymentPage = AppRoute(
  //   path: 'paymentPage',
  //   page: MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (_) => PaymentCubit()),
  //       BlocProvider(create: (_) => PpobPaymentDetailCubit()),
  //       BlocProvider(create: (_) => PinCubit()),
  //     ],
  //     child: Builder(
  //       builder: (context) {
  //         var modal = context.modal<Map<String, dynamic>?>();
  //         double amount = 0;
  //         if (modal?['product'].runtimeType.toString() == 'PlnCustomerModel') {
  //           amount = AppFunction.extractNumberFromString(
  //               modal?['product'].totalBayar);
  //         } else {
  //           amount = modal?['product'].priceSell ?? 10000;
  //         }

  //         log('amount : $amount', name: 'paymentPageRoute');
  //         context.read<PaymentCubit>().getPaymentMethod(amount: amount);

  //         return const PaymentPage();
  //       },
  //     ),
  //   ),
  // );
}
