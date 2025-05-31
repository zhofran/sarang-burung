import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/login/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future fetchLocation({required String username, required String password}) async {
    try {
      emit(LoginLoading());
      // log('username : $username', name: 'LoginCubit');
      // log('password : $password', name: 'LoginCubit');
      Response response = await AppApi.post(
        path: '/v1/auth/sign-in',
        withToken: false,
        formdata: {
          'username': username,
          'password': password,
        },
      );

      if (response.data['status'] == 200) {
        final loginData = LoginModel.fromJson(response.data['data']);
        // log('Location : $loginData', name: 'Login cubit location');

        emit(LoginSuccessSite(dataLogin: loginData));
      } else {
        emit(const LoginFailed(message: 'Maaf, username atau kata sandi salah'));
      }
    } catch (e) {
      log('err : $e', name: 'LoginCubit');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Login',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(LoginError(model: model));
    }
  }

  Future<void> login({required String username, required String password, required String siteId}) async {
    try {
      emit(LoginLoading());
      // log('username : $username', name: 'LoginCubit');
      // log('password : $password', name: 'LoginCubit');
      // log('Site Id  : $siteId', name: 'LoginCubit');
      Response response = await AppApi.post(
        path: '/v1/auth/sign-in/choose',
        withToken: false,
        formdata: {
          'username': username,
          'password': password,
          'siteId': siteId,
        },
      );

      if (response.data['status'] == 200) {
        // log(response.data['data']['user'].toString(), name: 'Log Login Cubit');
        await AppApi.keepToken(
          token: response.data['data']['token'],
          username: username,
          password: password,
          siteId: siteId,
        );

        // save data user
        await AppApi.setAuth(value: jsonEncode(response.data['data']['user']));

        emit(LoginSuccess());
      } else {
        emit(const LoginFailed(message: 'Maaf, username atau kata sandi salah'));
      }
    } catch (e) {
      log('err : $e', name: 'LoginCubit');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Login',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(LoginError(model: model));
    }
  }
}
