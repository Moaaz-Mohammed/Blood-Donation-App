import 'package:blood_donation/usable_widgets/custom_button.dart';
import 'package:blood_donation/usable_widgets/custom_sized_box_height.dart';
import 'package:blood_donation/model/user_donations_model.dart';
import 'package:blood_donation/services/store.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/functions.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddNewDonation extends StatefulWidget {
  const AddNewDonation({Key? key}) : super(key: key);

  @override
  State<AddNewDonation> createState() => _AddNewDonationState();
}

class _AddNewDonationState extends State<AddNewDonation> {
  TextEditingController patientNameController = TextEditingController();
  TextEditingController donationAddressController = TextEditingController();
  TextEditingController donationTimeController = TextEditingController();
  TextEditingController donationDateController = TextEditingController();
  TextEditingController donationNotesController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: Constants.primaryPadding,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.headline2,
                controller: patientNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintStyle: Theme.of(context).textTheme.headline2,
                  hintText: LocaleKeys.patient_name.tr(),
                ),
                validator: (value) {
                  value == null ? LocaleKeys.required.tr() : null;
                  return null;
                },
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2,
                controller: donationTimeController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.watch_later),
                  hintStyle: Theme.of(context).textTheme.headline2,
                  hintText: LocaleKeys.donation_time.tr(),
                ),
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    donationTimeController.text =
                        value!.format(context).toString();
                  });
                },
                validator: (value) {
                  value == null ? LocaleKeys.required.tr() : null;
                  return null;
                },
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2,
                controller: donationDateController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range),
                  hintStyle: Theme.of(context).textTheme.headline2,
                  hintText: LocaleKeys.donation_date.tr(),
                ),
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          firstDate: DateTime(2000))
                      .then((value) {
                    donationDateController.text =
                        DateFormat.yMMMd().format(value!);
                  });
                },
                validator: (value) {
                  value == null ? LocaleKeys.required.tr() : null;
                  return null;
                },
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2,
                controller: donationAddressController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on),
                  hintStyle: Theme.of(context).textTheme.headline2,
                  hintText: LocaleKeys.donation_address.tr(),
                ),
                validator: (value) {
                  value == null ? LocaleKeys.required.tr() : null;
                  return null;
                },
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2,
                controller: donationNotesController,
                maxLines: 3,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.notes),
                  hintStyle: Theme.of(context).textTheme.headline2,
                  hintText: LocaleKeys.notes.tr(),
                ),
                validator: (value) {
                  value == null ? LocaleKeys.required.tr() : null;
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                title: LocaleKeys.submit.tr(),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Store()
                        .addDonation(UserDonationsModel(
                            donationAddress: donationAddressController.text,
                            donationTime: donationTimeController.text,
                            donationDate: donationDateController.text,
                            PatientName: patientNameController.text,
                            donationNotes: donationNotesController.text))
                        .then((value) {
                      Functions.showToastMsg(
                              title: LocaleKeys.added_successfully.tr())
                          .then((value) {
                        Navigator.pop(context);
                      });
                    });
                  }
                },
              )
            ],
          ),
        ));
  }
}
