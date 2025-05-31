import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_state.dart';

class VisibilityCubit extends Cubit<VisibilityState> {
  VisibilityCubit() : super(VisibilityInitial());

  bool passwordVisibility = true;
  
  void togglePassVisibility(){
    emit(VisibilityLoading());
    passwordVisibility = !passwordVisibility;
    emit(VisibilitySuccess());
  }
}
