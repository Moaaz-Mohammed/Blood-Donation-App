import 'package:blood_donation/main_splash_screen.dart';
import 'package:blood_donation/services/cache_shared_preferences.dart';
import 'package:blood_donation/state_management/bloc/Cubit.dart';
import 'package:blood_donation/state_management/bloc/States.dart';
import 'package:blood_donation/state_management/provider/model_hud.dart';
import 'package:blood_donation/translations/codegen_loader.g.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'Styles/CustomColors.dart';
import 'Styles/Themes/DarkTheme.dart';
import 'Styles/Themes/LightTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await CacheSharedPreferences.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CustomColors.primaryRedColor,
    ),
  );

  bool onBoarding = CacheSharedPreferences.getData(key: 'onBoarding') ?? false;
  bool isDark =
      CacheSharedPreferences.getData(key: 'isDark') == null ? false : true;
  runApp(
    EasyLocalization(
        child: MyApp(
          onBoarding: onBoarding,
          isDark: isDark,
        ),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        fallbackLocale: const Locale('ar', 'EG'),
        assetLoader: const CodegenLoader(),
        path: 'assets/translations'),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.onBoarding,
    this.isDark,
  });

  final onBoarding;
  final isDark;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
      ],
      child: BlocProvider(
        create: (BuildContext context) =>
            AppCubit()..changeAppMode(fromShared: isDark),
        child: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp(
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: LocaleKeys.app_name.tr(),
              home: MainSlashScreen(
                onBoarding: onBoarding,
              ),
              theme: LightTheme,
              darkTheme: DarkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ),
      ),
    );
  }
}
