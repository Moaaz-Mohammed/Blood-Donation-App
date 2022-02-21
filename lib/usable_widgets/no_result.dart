import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../shared/images.dart';

class WidgetNoResult extends StatelessWidget {
  const WidgetNoResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: double.infinity,
        height: height * 0.35,
        padding: Constants.primaryPadding,
        child: Image.asset(
          Images.noResultImage,
          width: double.infinity,
        ),
      ),
    );
  }
}
