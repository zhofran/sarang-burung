import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> splash() async {
    emit(SplashLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('token') ?? '';
      final username = prefs.getString('username') ?? '';
      final password = prefs.getString('password') ?? '';
      final siteId = prefs.getString('siteId') ?? '';

      if ([token, username, password, siteId].any((element) => element.isEmpty)) {
        log('Token or credentials are missing', name: 'SplashCubit');
        emit(const SplashFailed(message: 'Token or credentials missing.'));
        return;
      }

      final response = await AppApi.post(
        path: '/v1/auth/sign-in/choose',
        withToken: false,
        formdata: {
          'username': username,
          'password': password,
          'siteId': siteId,
        },
      );

      if (response.data['status'] == 200) {
        await AppApi.keepToken(
          token: response.data['data']['token'],
          username: username,
          password: password,
          siteId: siteId,
        );

        await AppApi.setAuth(value: jsonEncode(response.data['data']['user']));
        emit(SplashSuccess());
      } else {
        emit(const SplashFailed(message: 'Invalid username or password.'));
      }
    } catch (e) {
      log('Error occurred: $e', name: 'SplashCubit');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Splash Error',
        content: e.toString(),
        type: AppAPIType.post,
      );
      emit(SplashError(model: model));
    }
  }
}
