import 'package:blood_donation/Screens/on_boarding/boarding_model.dart';
import 'package:flutter/material.dart';

import '../../UsableWidgets/custom_sized_box_height.dart';
import '../../shared/constants.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({
    Key? key,
    BoardingModel? this.model,
  }) : super(key: key);
  final model;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.31,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: Constants.primaryBorderRadius,
              child: Image(
                image: AssetImage(model!.image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const CustomSizedBoxHeight(),
          const CustomSizedBoxHeight(),
          Text(model.title, style: Theme.of(context).textTheme.headline5),
          const CustomSizedBoxHeight(),
          Text(model.body, style: Theme.of(context).textTheme.headline2),
        ],
      ),
    );
  }
}
