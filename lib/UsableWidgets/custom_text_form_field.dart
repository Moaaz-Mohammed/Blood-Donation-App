import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';
import '../shared/constants.dart';
import '../translations/locale_keys.g.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.maxLine = 1,
  }) : super(key: key);

  final hint;
  final controller;
  final keyboardType;
  final obscureText;
  final icon;
  final maxLine;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.grey[600],
            ),
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return '$hint ${LocaleKeys.required.tr()} ';
          }
          return null;
        },
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.grey[600],
        style: const TextStyle(
          color: Colors.red,
        ),
        maxLines: maxLine,
        decoration: InputDecoration(
          suffixIcon: icon != null
              ? Icon(
                  icon,
                  color: CustomColors.primaryRedColor,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: Constants.primaryBorderRadius,
            borderSide: const BorderSide(
              color: CustomColors.primaryGreyColor,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: Constants.primaryBorderRadius,
            borderSide: const BorderSide(
              color: CustomColors.primaryGreyColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: Constants.primaryBorderRadius,
            borderSide: BorderSide(
              color: Theme.of(context).indicatorColor,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          hintStyle: TextStyle(
            color: Colors.grey[600],
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
