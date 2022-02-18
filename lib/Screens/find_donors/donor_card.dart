import 'package:blood_donation/Styles/CustomColors.dart';
import 'package:blood_donation/UsableWidgets/custom_sized_box_height.dart';
import 'package:blood_donation/shared/Images.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorCard extends StatelessWidget {
  const DonorCard({
    Key? key,
    required this.donorName,
    required this.donorPhone,
    required this.donorAddress,
    required this.donorBloodType,
  }) : super(key: key);
  final String donorName;
  final String donorPhone;
  final String donorAddress;
  final String donorBloodType;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Constants.primaryBorderRadius,
          color: CustomColors.primaryGreyColor.withOpacity(0.5),
        ),
        padding: Constants.primaryPadding,
        child: ExpansionTile(
          iconColor: CustomColors.primaryRedColor,
          collapsedIconColor: CustomColors.primaryRedColor,
          title: Text(
            donorName,
            style: Theme.of(context).textTheme.headline2,
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 30,
                      color: CustomColors.primaryRedColor,
                    ),
                    Text(
                      donorAddress,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            color:
                                CustomColors.primaryDarkColor.withOpacity(0.5),
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.bloodtype,
                      size: 30,
                      color: CustomColors.primaryRedColor,
                    ),
                    Text(
                      donorBloodType,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            color:
                                CustomColors.primaryDarkColor.withOpacity(0.5),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const CustomSizedBoxHeight(),
            const CustomSizedBoxHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  elevation: 1,
                  child: Image.asset(
                    Images.whatsappImage,
                    height: 35,
                  ),
                  onPressed: () async {
                    await launch(
                        'https://wa.me/+2$donorPhone?text= السلام عليكم ورحمة الله وبركاته');
                  },
                ),
                FloatingActionButton(
                  elevation: 1,
                  child: const Icon(
                    Icons.phone,
                    size: 30,
                    color: CustomColors.primaryDarkColor,
                  ),
                  onPressed: () async {
                    await launch('tel:$donorPhone');
                  },
                ),
              ],
            ),
            const CustomSizedBoxHeight(),
            const CustomSizedBoxHeight(),
          ],
        ),
      ),
    );
  }
}
