import 'package:blood_donation/Styles/CustomColors.dart';
import 'package:blood_donation/UsableWidgets/custom_sized_box_width.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.name,
    required this.time,
    required this.date,
    required this.address,
    required this.notes,
  }) : super(key: key);
  final String? name;
  final String? date;
  final String? time;
  final String? address;
  final String? notes;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: Constants.primaryPadding,
      decoration: BoxDecoration(
        borderRadius: Constants.primaryBorderRadius,
        color: CustomColors.primaryGreyColor.withOpacity(0.7),
      ),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -45,
            child: Column(
              children: [
                Text(
                  date!,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  time!,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
          const CustomSizedBoxWidth(),
          const CustomSizedBoxWidth(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name!,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: CustomColors.primaryRedColor),
              ),
              Text(
                address!,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(color: CustomColors.primaryRedColor),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: width * 0.7,
                child: Text(
                  notes!,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: CustomColors.primaryDarkColor.withOpacity(0.5),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
