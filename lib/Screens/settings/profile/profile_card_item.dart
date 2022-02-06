import 'package:flutter/material.dart';
import '../../../Styles/CustomColors.dart';
import '../../../UsableWidgets/custom_sized_box_width.dart';
import '../../../shared/Constants.dart';

class ProfileCardItem extends StatelessWidget {
  const ProfileCardItem({
    Key? key,
    required this.title,
    required this.subTitle,
  });
  final title;
  final subTitle;

  @override
  Widget build(BuildContext context) {
  
    return Container(
      padding: Constants.primaryPadding,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline2?.copyWith(
              color: CustomColors.primaryRedColor
            )
          ),
          CustomSizedBoxWidth(),
          Expanded(
            child: Center(
              child: Text(
                subTitle,
                style: Theme.of(context).textTheme.headline1
              ),
            ),
          ),
        ],
      ),
    );
  }
}
