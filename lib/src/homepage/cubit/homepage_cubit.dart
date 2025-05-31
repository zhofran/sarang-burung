import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:report_sarang/env/class/app_env.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());

  bool isShowSaldo = true;

  void changeShowSaldo() {
    emit(HomepageOnLoading());
    isShowSaldo = !isShowSaldo;
    emit(HomepageOnSuccess());
  }
}
