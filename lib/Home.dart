import 'package:blood_donation/Widgets/PatientButton.dart';
import 'package:blood_donation/Widgets/VolunteerButton.dart';
import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Widgets/Drawer.dart';

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
            theme: lighttheme,
            darkTheme: darktheme,
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
                        Image.asset(Constants.logoImage),
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