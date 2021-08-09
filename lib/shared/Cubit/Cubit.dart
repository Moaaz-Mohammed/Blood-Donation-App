import 'package:bloc/bloc.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
