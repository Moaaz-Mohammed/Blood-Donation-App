import 'package:blood_donation/Styles/custom_colors.dart';
import 'package:flutter/material.dart';

class DrawerListCard extends StatelessWidget {
  const DrawerListCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData? icon;
  final String? title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
                color: CustomColors.primaryGreyColor.withOpacity(0.5)),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: CustomColors.primaryRedColor,
              size: 27.5,
            ),
            SizedBox(
              width: width * 0.1,
            ),
            Text(
              title!,
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ),
    );
  }
}
