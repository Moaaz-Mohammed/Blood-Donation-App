import 'package:flutter/material.dart';

import '../Styles/custom_colors.dart';
import '../shared/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.titleColor = CustomColors.primaryWhiteColor,
    this.height = 60.0,
    this.backgroundColor = CustomColors.primaryRedColor,
    this.borderColor = CustomColors.primaryRedColor,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final double height;
  final Color titleColor;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialButton(
      height: height,
      // padding: const EdgeInsets.symmetric(vertical: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: Constants.primaryBorderRadius,
        side: BorderSide(
          color: borderColor,
        ),
      ),
      minWidth: width,
      onPressed: () {
        onTap();
      },
      elevation: 0.0,
      hoverColor: backgroundColor,
      focusColor: backgroundColor,
      color: backgroundColor,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4?.copyWith(
              color: titleColor,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
