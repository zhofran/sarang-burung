import 'package:flutter/material.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/class/app_shortcut.dart';
import 'package:report_sarang/env/extension/on_context.dart';
import 'package:report_sarang/src/splash/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (_, state) async {
          if (state is SplashSuccess) {
            context.toReplacementNamed(
              route: AppRoute.dashboardPage.path
            );
          }
          if (state is SplashFailed || state is SplashError) {
            context.removeToNamed(route: AppRoute.loginPage.path);
          }
        },
        builder: (_, state) {
          return Container(
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [Color(0xFF1A7F09), Color(0xFF82CD47)],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //   ),
            // ),
            color: Color(0xFF0F6646),
            height: my.query.size.height,
            width: my.query.size.width,
            child: Center(
              child: Image.asset(
                width: 300,
                height: 300,
                AppAsset.appLogo,
              ),
            ),
          );
        },
      ),
    );
  }
}
