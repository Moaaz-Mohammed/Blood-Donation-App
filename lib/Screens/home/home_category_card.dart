import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';

class HomeCategoryCard extends StatelessWidget {
  const HomeCategoryCard(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      required this.content,
      required this.image})
      : super(key: key);
  final backgroundColor;
  final title;
  final content;
  final image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 2,
      color: backgroundColor,
      child: SizedBox(
        height: height * 0.35,
        width: width * 0.4282,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: Image.asset(
                image,
                height: height * 0.075,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: CustomColors.primaryWhiteColor),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                content,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: CustomColors.primaryGreyColor.withOpacity(0.7),
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
