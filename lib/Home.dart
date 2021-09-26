import 'package:blood_donation/Modules/patient_page.dart';
import 'package:blood_donation/Modules/volunteer_page.dart';
import 'package:blood_donation/Widgets/PatientButton.dart';
import 'package:blood_donation/Widgets/VolunteerButton.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    double width = MediaQuery.of(context).size.width;
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
                        CachedNetworkImage(
                          imageUrl:
                          "https://i.ibb.co/6W2v8Sk/57382-love-transfusion-donation-vector-blood-donor-world.png",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
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