import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Styles/Themes/DarkTheme.dart';
import 'Styles/Themes/LightTheme.dart';
import 'UsableWidgets/Drawer.dart';
import 'UsableWidgets/PatientButton.dart';
import 'UsableWidgets/VolunteerButton.dart';

class home_page extends StatefulWidget
{
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context)=>AppCubit(),
      child: BlocBuilder<AppCubit,AppStates>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: LightTheme,
            darkTheme: DarkTheme,
            home: Scaffold(
              appBar: AppBar(
                title: Text('الرئيسية'),
                centerTitle: true,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Constants.LogoImage),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        PatientButton(),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        VolunteerButton(),
                      ],
                    ),
                  ),
                ),
              ),
              drawer: CustomDrawer(),
            ),
          );
        },
      ),
    );
  }
}