import 'package:blood_donation/screens/on_boarding/choose_language.dart';
import 'package:blood_donation/screens/on_boarding/continue_button.dart';
import 'package:blood_donation/screens/on_boarding/on_boarding_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/cache_shared_preferences.dart';
import '../../shared/functions.dart';
import '../../shared/images.dart';
import '../../styles/custom_colors.dart';
import '../../translations/locale_keys.g.dart';
import 'boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: Images.helpImage,
      title: 'ساعد غيرك!',
      body: 'تقدر تساعد غيرك سواء بتبرعك بالدم أو غيرها من المساعدات',
    ),
    BoardingModel(
      image: Images.friendsImage,
      title: 'متشيلش هم!',
      body:
          '	إحنا مع بعض طول الوقت متشيلش هم حاجه كلنا جنبك . نزل مشكلتك و إن شاء الله محلوله 😁',
    ),
  ];

  void submit() {
    CacheSharedPreferences.saveData(
      key: 'onBoarding',
      value: true,
    ).then(
      (value) {
        if (value) {
          Functions.navigatorPushAndRemove(
            context: context,
            screen: const ChooseLanguageScreen(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(LocaleKeys.skip.tr(),
                style: Theme.of(context).textTheme.headline2),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardController,
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) {
                return OnBoardingCard(
                  model: boarding[index],
                );
              },
              itemCount: boarding.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: CustomizableEffect(
                    spacing: 5.0,
                    dotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(20),
                      verticalOffset: -5.0,
                      color: CustomColors.primaryGreyColor,
                      rotationAngle: 75.0,
                      width: width * 0.05,
                      height: 10,
                    ),
                    activeDotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors.primaryRedColor,
                      rotationAngle: 75.0,
                      width: width * 0.05,
                      height: 10,
                    ),
                  ),
                  count: boarding.length,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(
                    50.0,
                  ),
                  onTap: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 1000,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const ContinueButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
