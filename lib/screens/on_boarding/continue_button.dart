import 'package:flutter/material.dart';

import '../../Styles/custom_colors.dart';
import '../../shared/constants.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.primaryRedColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 15.0,
          color: CustomColors.primaryWhiteColor,
        ),
      ),
    );
  }
}
