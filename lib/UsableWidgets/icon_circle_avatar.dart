import 'package:blood_donation/Styles/CustomColors.dart';
import 'package:flutter/material.dart';

class IconCircleAvatar extends StatelessWidget {
  const IconCircleAvatar({
    Key? key,
    required this.child,
    this.iconColor,
    required this.function,
  }) : super(key: key);
  final child;
  final Color? iconColor;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: CustomColors.primaryRedColor.withOpacity(0.3),
        child: child,
      ),
    );
  }
}
