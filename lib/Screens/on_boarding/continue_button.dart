import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';
import '../../shared/Constants.dart';

class continue_button extends StatelessWidget {
  const continue_button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 35,
      width: width * 0.2,
      decoration: BoxDecoration(
        color: CustomColors.primaryRedColor,
        borderRadius: Constants.primaryBorderRadius,
      ),
      child: Icon(
        Icons.arrow_forward_ios,
        color: CustomColors.primaryWhiteColor,
      ),
    );
  }
}
