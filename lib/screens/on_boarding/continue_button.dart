import 'package:flutter/material.dart';

import '../../Styles/custom_colors.dart';
import '../../shared/constants.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

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
      child: const Icon(
        Icons.arrow_forward_ios,
        color: CustomColors.primaryWhiteColor,
      ),
    );
  }
}
