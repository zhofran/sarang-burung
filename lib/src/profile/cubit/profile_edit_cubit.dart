import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/src/profile/models/user_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit() : super(ProfileEditInitial());

  Future<void> editProfile(
      {required String name, required String phone}) async {
    try {
      emit(ProfileEditOnLoading());

      Response response = await AppApi.post(
        path: '/profile/update',
        formdata: {
          "name": name,
          "number_phone": phone,
        },
      );

      log('response : $response', name: 'editProfile');
      if (response.statusCode == 200) {
        UserModel dataCurrentUser =
            UserModel.fromJson(response.data['data'] ?? {});

        await AppApi.setAuth(value: jsonEncode(dataCurrentUser));
        emit(ProfileEditOnSuccess());
      }
    } catch (e) {
      log('err : $e', name: 'editProfile');
      var model = await AppReportModel.onDefault(
        api: [],
        title: 'Gagal Profile',
        content: e.toString(),
        type: AppAPIType.post,
      );

      emit(ProfileEditOnError(model: model));
    }
  }
}
