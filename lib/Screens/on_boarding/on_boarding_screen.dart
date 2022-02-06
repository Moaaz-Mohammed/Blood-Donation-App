import 'package:blood_donation/Screens/on_boarding/choose_language.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Styles/CustomColors.dart';
import '../../services/cache_shared_preferences.dart';
import '../../shared/Constants.dart';
import '../../shared/Functions.dart';
import '../auth/log_in_screen.dart';
import 'boarding_model.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: Constants.LogoImage,
      title: 'هتشوف كل عروض صان الحجر',
      body:'تقدر تعرف العروض الموجوده وتقدر تضيف عرض من عندك ونعرضهولك في التطبيق',
    ),
    BoardingModel(
      image: Constants.LogoImage,
      title: 'هتشوف كل مطاعم صان الحجر',
      body: 'تقدر تعرف الوجبات الموجوده وتقدر تطلبها وتوصلك لعند بيتك',
    ),
    BoardingModel(
      image: Constants.LogoImage,
      title: 'هتشوف كل صيدليات صان الحجر',
      body: 'بسهوله ومن بيتك تقدر تعرف علاجك موجود فين وتقدر تطلبه ويوصلك لعند بيتك',
    ),
    BoardingModel(
      image: Constants.LogoImage,
      title: 'هتشوف كل السوبر ماركت ',
      body: 'تقدر تطلب اي طلب ويوصلك لعند بيتك ولو انت صاحب محل تقدر تضيفه وتقدر تضيف العروض الموجوده عندك',
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
            screen: ChooseLanguageScreen(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                'تخطي',
                style: TextStyle(
                  color: CustomColors.primaryWhiteColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
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
                  return buildBoardingItem(
                    model: boarding[index],
                    height: height,
                    width: width,
                  );
                },
                itemCount: boarding.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: CustomColors.primaryRedColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: CustomColors.primaryRedColor,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem({
    required BoardingModel model,
    required height,
    required width,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: height * 0.35,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: Constants.primaryBorderRadius,
              child: Image(
                image: AssetImage('${model.image}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              color: CustomColors.primaryRedColor,
            ),
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
