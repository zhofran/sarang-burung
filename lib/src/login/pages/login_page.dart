import 'dart:async';

import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/class/app_shortcut.dart';
import 'package:report_sarang/env/extension/on_context.dart';
import 'package:report_sarang/env/widget/app_button.dart';
import 'package:report_sarang/env/widget/bug_catcher.dart';
import 'package:report_sarang/src/login/cubit/visibility_cubit.dart';
import 'package:report_sarang/src/login/models/login_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:report_sarang/src/login/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final siteIdController = TextEditingController();

  Timer? debounce;

  SiteElement? selectedLocation;

  @override
  void initState() {
    super.initState();
    // usernameController.addListener(_onCredentialsChanged);
    passwordController.addListener(_onCredentialsChanged);
  }

  void _onCredentialsChanged() {
    final loginCubit = context.read<LoginCubit>();

    // Batalkan debounce sebelumnya jika ada
    if (debounce?.isActive ?? false) debounce?.cancel();

    // Mulai debounce baru
    debounce = Timer(const Duration(milliseconds: 1000), () {
      final username = usernameController.text.trim();
      final password = passwordController.text.trim();

      if (username.isNotEmpty && password.isNotEmpty) {
        loginCubit.fetchLocation(username: username, password: password);
      }
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    final visibleCubit = context.watch<VisibilityCubit>();
    
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            BugSheet.withModel(
              state.model,
              pagePath: 'login_page.dart',
              statePath: 'login_cubit.dart',
            ).openWith(context);
          }

          if (state is LoginFailed) {
            context.alert(label: state.message);
          }

          if (state is LoginSuccess) {
            context.toReplacementNamed(
              route: AppRoute.dashboardPage.path
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mari Masuk",
                          style: GoogleFonts.outfit(
                            fontSize: 37,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Selamat datang kembali, \n Anda telah dirindukan",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const Gap(30),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: my.color.primary,
                                    ),
                                    hintText: 'Nama Pengguna',
                                    hintStyle: GoogleFonts.outfit(
                                      color: my.color.primary,
                                      fontSize: 15,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: my.color.primary,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: my.color.primary,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  cursorHeight: 25,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: visibleCubit.passwordVisibility,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: my.color.primary,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        visibleCubit.togglePassVisibility();
                                      },
                                      icon: Icon(
                                        visibleCubit.passwordVisibility
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                      ),
                                      color: my.color.primary,
                                    ),
                                    hintText: 'Kata Sandi',
                                    hintStyle: GoogleFonts.outfit(
                                      color: my.color.primary,
                                      fontSize: 15,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: my.color.primary,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: my.color.primary,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  cursorHeight: 25,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              if (state is LoginLoading)
                                const CircularProgressIndicator(),
                              if (state is LoginSuccessSite)
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField2<SiteElement>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: my.color.primary,
                                          width: 2,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.location_on,
                                        color: my.color.primary,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: my.color.primary,
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                    items: state.dataLogin.sites.where((element) => element.site?.deletedAt == null).map((location) {
                                      return DropdownMenuItem<SiteElement>(
                                        value: location,
                                        child: Text(
                                          location.site!.name ?? 'Unknown' ,
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            color: my.color.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (location) {
                                      setState(() {
                                        selectedLocation = location;
                                        siteIdController.text = location!.siteId ?? '';
                                      });
                                    },
                                    hint: Text(
                                      'Pilih Lokasi',
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        color: my.color.primary,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      // height: 50,
                                      padding:
                                          const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30),
                                        border: Border.all(
                                          width: 0,
                                          color: Colors.transparent
                                        ),
                                        // color: My.grey3,
                                      ),
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: my.color.primary,
                                      ),
                                      iconSize: 24,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                  ),
                                ),
                              const Gap(10),
                              SizedBox(
                                width: 300,
                                child: AppButton(
                                  label: 'Masuk',
                                  backgroundColor: my.color.primary,
                                  radius: 30,
                                  onTap: () {
                                    context.toNamed(route: AppRoute.dashboardPage.path);
                                    // if (formKey.currentState!.validate()) {
                                    //   context.read<LoginCubit>().login(
                                    //     username: usernameController.text,
                                    //     password: passwordController.text,
                                    //     siteId: siteIdController.text
                                    //   );
                                    // }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Image.asset(
                  //     AppAsset.appLogo
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
