import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لغة التطبيق'),
      ),
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'برجاء إختيار لغة التطبيق:',
          style: Theme.of(context).textTheme.headline4,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          height: 30,
        ),

      ],
    ));
  }
}
