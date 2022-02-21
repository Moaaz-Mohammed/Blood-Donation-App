import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../usable_widgets/custom_sized_box_height.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final dynamic model;
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
