import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                theme: lighttheme,
                darkTheme:darktheme,
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
                        color: Colors.red,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(Constants.bloodtypes),
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
