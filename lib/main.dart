import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //final bool isDark;
  MyApp();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeAppMode(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode: ThemeMode.system,
            home: home_page(),
          );
        },
      ),
    );
  }
}
