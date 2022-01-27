import 'package:flutter/material.dart';

import '../shared/Constants.dart';
import 'custom_button.dart';
import 'custom_sized_box_width.dart';

class CustomDialogDoYouWant extends StatelessWidget {
  const CustomDialogDoYouWant({
    Key? key,
    required this.onTapYes,
    required this.title,
  });

  final onTapYes;
  final title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: Constants.primaryBorderRadius,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Row(
        children: [
          Expanded(
            child: CustomButton(
              height: 40.0,
              title: 'نعم',
              onTap: () {
                onTapYes();
              },
              backgroundColor: Colors.green,
              borderColor: Colors.green,
            ),
          ),
          CustomSizedBoxWidth(),
          Expanded(
            child: CustomButton(
              height: 40.0,
              title: 'لا',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
