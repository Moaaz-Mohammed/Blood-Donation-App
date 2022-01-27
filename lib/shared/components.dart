import 'package:blood_donation/shared/Constants.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';

navigateTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget TitleText({@required String? text}) => Text(
      text!,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );

Widget defaultText({@required String? text,}) => Text(
      text!,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: CustomColors.primaryRedColor),
    );

class CustomDialog extends StatelessWidget {
  final String? title, description1, description2, buttonText;
  final Image? image;

  CustomDialog(
      {
      this.title,
      this.buttonText,
      this.description1,
      this.description2,
      this.image,
      }
      );
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(top: 80, bottom: 5, left: 16, right: 16),
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: CustomColors.primaryRedColor,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0))
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 16,
                ),
                Text(
                  description1!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  description2!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}

Widget ArticleHeadText({@required String? text,}) =>Text(
      text!,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.primaryRedColor),
    );

Widget ArticleContentText({@required String? text,}) => Text(
      text!,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CustomColors.primaryRedColor),
    );

Widget DetailtsText ({required String? text})=>Text(text!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),);

