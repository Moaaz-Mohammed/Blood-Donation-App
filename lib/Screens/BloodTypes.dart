import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Styles/Themes/DarkTheme.dart';
import '../Styles/Themes/LightTheme.dart';

class BloodTypes extends StatefulWidget {
  const BloodTypes({Key? key}) : super(key: key);
  @override
  _BloodTypesState createState() => _BloodTypesState();
}

class _BloodTypesState extends State<BloodTypes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (conext, child) {
        return BlocProvider(
          create: (context)=>AppCubit(),
          child: BlocConsumer<AppCubit,AppStates>
            (
            listener: (context,state){},
            builder: (context,state)
            {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: LightTheme,
                darkTheme:DarkTheme,
                themeMode: ThemeMode.system,
                home: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    title: Text('فصائل الدم'),
                    centerTitle: true,
                    leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Constants.redColor,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(Constants.BloodTypesImage),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
