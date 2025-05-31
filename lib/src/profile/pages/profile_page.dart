import 'package:flutter/material.dart';
import 'package:report_sarang/env/widget/app_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText(text: 'Profile Page'),
      ),
    );
  }
}
