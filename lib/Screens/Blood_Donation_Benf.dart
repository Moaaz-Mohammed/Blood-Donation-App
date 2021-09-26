import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blood_Donation_Benf extends StatefulWidget {
  const Blood_Donation_Benf({Key? key}) : super(key: key);
  @override
  _Blood_Donation_BenfState createState() => _Blood_Donation_BenfState();
}

class _Blood_Donation_BenfState extends State<Blood_Donation_Benf> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (conext, child) {
        return BlocProvider(
            create: (context)=>AppCubit(),
          child: BlocConsumer<AppCubit,AppStates>
            (
            listener: (context,state){},
            builder: (context,state)
            {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lighttheme,
                darkTheme:darktheme,
                themeMode: ThemeMode.system,
                home: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    title: Text('معلومات تهمك'),
                    centerTitle: true,
                    leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Constants.redColor,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: ArticleHeadText(
                                          text: 'لماذا يجب عليك التبرع؟'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ArticleContentText(
                                              text:'1. كل ثلاث ثوان هناك شخص يحتاج إلى نقل الدم.'),
                                          ArticleContentText(
                                              text:'2. واحد من كل عشرة مرضى يدخلون المستشفى في حاجة إلى نقل الدم.'),
                                          ArticleContentText(
                                              text:'3. دمك يمكن أن ينقذ أربعة أشخاص عند فصل مكوناته وليس شخصًا واحدًا.'),
                                          ArticleContentText(
                                              text:'4. تعيد عملية التبرع بالدم الحيوية والنشاط للجسم بسبب تجدد خلايا الدم.'),
                                          ArticleContentText(
                                              text:'5. يمكن للمتبرع الحصول على نتائج فحوصات المسح الخاصة به، بما فيها فصيلة الدم.'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(child: ArticleHeadText(text: 'كيفية التبرع؟')),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ArticleContentText(
                                          text:
                                          'تتم عملية التبرع عن طريق جمع الدم في كيس يحتوي على مادة مانعة للتجلط متصل بأبرة معقمة تستعمل لمره واحدة فقط توصل من الوريد في الذراع، وتتم عملية التبرع بالدم في فترة زمنية تقريباً 5 - 10 دقائق في هذه الفترة يكون المتبرع تحت الرعاية الطبية المباشرة، ولكن تستغرق الزيارة بأكملها مدة تتراوح بين 15-20 دقيقة.'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: ArticleHeadText(
                                          text:
                                          'ما الأسباب التي لا يمكنك معها التبرع بالدم؟'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ArticleContentText(
                                              text:
                                              'وجود أي تعب من المتاعب الصحية التالية:'),
                                          ArticleContentText(
                                              text:
                                              'أ- جميع أنواع الأنيميا عدا أنيميا نقص الحديد.'),
                                          ArticleContentText(
                                              text: '1. أمراض القلب والحمى الروماتيزمية.'),
                                          ArticleContentText(
                                              text: '2. الأمراض الصدرية المزمنة.'),
                                          ArticleContentText(text: '3. ارتفاع الضغط المزمن.'),
                                          ArticleContentText(
                                              text: '4. الالتهاب الكبدي الفيروسي.'),
                                          ArticleContentText(text: '5. مرض البول السكري.'),
                                          ArticleContentText(text: '6. حالات الفشل الكلوي.'),
                                          ArticleContentText(text: '7. حالات تضخم الكبد.'),
                                          ArticleContentText(
                                              text:
                                              '8. الات التشنجات والصرع والإغماء المتكرر.'),
                                          ArticleContentText(
                                              text: '9. زيادة أو نقص إفرازات الغدة الدرقية.'),
                                          ArticleContentText(text: '10. الحمل.'),
                                          ArticleContentText(text: '11. أمراض نزف الدم.'),
                                          ArticleContentText(text: '12. الأمراض الوراثية.'),
                                          ArticleContentText(text: '13. الأمراض النفسية.'),
                                          ArticleContentText(
                                              text: '14. أي عمليات خلال فترة ثلاثة أشهر.'),
                                          ArticleContentText(
                                              text:
                                              'ب- إذا كان المتبرع يعاني من الأعراض التالية:'),
                                          ArticleContentText(
                                              text: '1. فقدان غير متوقع للوزن والشهية'),
                                          ArticleContentText(text: '2. عرق ليلى.'),
                                          ArticleContentText(text: '3. سخونية ليلية.'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: ArticleHeadText(
                                          text: 'متى يمكن معاودة التبرع بالدم؟'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ArticleContentText(
                                          text:
                                          'ينصح بالتبرع بالدم بعد مرور 6 أشهر من أخر تبرع بالدم في حين أنه لتكرار التبرع بالدم قبل ذلك في الفترة من 3-4 أشهر، ولكن يجب أن يكون المتبرع لائق طبياً'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: ArticleHeadText(
                                          text:
                                          'كمية الدم التي يتم أخذها في المرة الواحدة؟'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ArticleContentText(
                                          text:
                                          'يتم أخذ من 400 - 450 مليلتر، وهو ما يمثل حوالي 12/1 من حجم الدم الموجود داخل جسم كل إنسان، والذي يتراوح بين 5 - 6 لترات.'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
