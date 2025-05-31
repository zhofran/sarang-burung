import 'package:flutter/material.dart';
import 'package:report_sarang/env/class/app_shortcut.dart';
import 'package:report_sarang/env/widget/app_text.dart';

part '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeController {
  @override
  Widget build(BuildContext context) {
    // shorcut to get value from theme, mediaquery, etc
    var my = AppShortcut.of(context);
    // varible to access cubit
    // var homepageCubit = context.watch<HomepageCubit>();
    // var profileCubit = context.watch<ProfileCubit>();

    return Scaffold(
      body: Center(
        child: AppText(
          text: 'Home page',
          textColor: my.color.primary,
        ),
      ),
    );
  }
}
