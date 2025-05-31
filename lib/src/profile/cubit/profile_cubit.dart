import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/profile/models/user_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserModel? user;

  Future<void> getProfile() async {
    emit(ProfileOnLoading());

    try {
      Response response = await AppApi.get(path: '/me');

      log('response : $response', name: 'ProfileCubit');

      if (response.statusCode == 200) {
        // save data user
        user = UserModel.fromJson(response.data['data'] ?? {});

        await AppApi.setAuth(value: jsonEncode(user));

        emit(ProfileOnSuccess(model: user!));
      } else {
        emit(ProfileOnFailed(message: response.data['message'] ?? ''));
      }
    } catch (e) {
      log('err : $e', name: 'ProfileCubit');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Profile',
        content: e.toString(),
        type: AppAPIType.get,
      );

      emit(ProfileOnError(model: model));
    }
  }
}
