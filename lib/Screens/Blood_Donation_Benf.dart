import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';
import '../translations/locale_keys.g.dart';

class DonationBenefitsScreen extends StatefulWidget {
  const DonationBenefitsScreen({Key? key}) : super(key: key);
  @override
  _DonationBenefitsScreenState createState() => _DonationBenefitsScreenState();
}

class _DonationBenefitsScreenState extends State<DonationBenefitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.important_info.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ExpansionTile(
                  expandedAlignment: Alignment.centerRight,
                  title: Text(
                    '1- ${LocaleKeys.importance_of_donating.tr()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: CustomColors.primaryRedColor),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        LocaleKeys.every_three_seconds.tr(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    const Divider(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.one_of_ten.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Divider(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.your_blood.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Divider(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.refresh_blood.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Divider(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.donor_can_get_results.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.centerRight,
                  title: Text(
                    '2- ${LocaleKeys.how_to_donate.tr()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: CustomColors.primaryRedColor),
                  ),
                  children: [
                    Text(
                      LocaleKeys.process_of_donating.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.centerRight,
                  title: Text(
                    '3- ${LocaleKeys.why_not_donating.tr()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: CustomColors.primaryRedColor),
                  ),
                  children: [
                    Text(
                      LocaleKeys.reasons_prevent_donating.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '4- ${LocaleKeys.when_redonate.tr()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: CustomColors.primaryRedColor),
                  ),
                  expandedAlignment: Alignment.centerRight,
                  children: [
                    Text(
                      LocaleKeys.when_can_redonate.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.centerRight,
                  title: Text(
                    '5- ${LocaleKeys.amount_of_blood_in_single_donate.tr()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: CustomColors.primaryRedColor),
                  ),
                  children: [
                    Text(
                      LocaleKeys.amount_of_blood.tr(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
