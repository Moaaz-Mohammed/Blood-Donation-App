import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/cache_shared_preferences.dart';
import 'States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  ThemeMode appMode = ThemeMode.light;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheSharedPreferences.saveData(key: 'isDark', value: isDark).then(
        (value) {
          emit(AppChangeModeState());
        },
      );
    }
  }

  bool isVisible = true;
  void showPassword() {
    isVisible = !isVisible;
    emit(ShowPasswordState());
  }
}
