import 'package:flutter/material.dart';

import '../../../shared/constants.dart';
import '../../../styles/custom_colors.dart';
import '../../../usable_widgets/custom_sized_box_width.dart';

class ProfileCardItem extends StatelessWidget {
  const ProfileCardItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.primaryPadding,
      child: Row(
        children: [
          Icon(
            icon,
            color: CustomColors.primaryRedColor,
          ),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: CustomColors.primaryRedColor)),
          const CustomSizedBoxWidth(),
          Expanded(
            child: Center(
              child:
                  Text(subTitle, style: Theme.of(context).textTheme.headline1),
            ),
          ),
        ],
      ),
    );
  }
}
