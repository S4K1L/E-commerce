import 'package:bdm/controllers/localization_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/controllers/theme_controller.dart';
import 'package:bdm/utils/app_constants.dart';
import 'package:bdm/utils/di.dart' as di;
import 'package:bdm/utils/message.dart';
import 'package:bdm/views/screens/auth/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Get.find<ServiceController>().fetchServiceInfo();
    Get.find<ServiceController>().fetchBanners();
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetMaterialApp(
              title: "BDM",
              debugShowCheckedModeBanner: false,
              // theme: themeController.darkTheme ? dark() : light(),
              theme:
                  themeController.darkTheme
                      ? ThemeData.dark().copyWith(
                        scaffoldBackgroundColor: const Color(0xff1a1c22),
                        cardColor: Colors.white.withAlpha(20),
                        shadowColor: Colors.black.withAlpha(100),
                        dividerColor: Colors.white.withAlpha(30),
                        iconTheme: const IconThemeData(color: Colors.white),
                        appBarTheme: const AppBarTheme(
                          backgroundColor: Color(0xff23252b),
                          elevation: 0,
                          centerTitle: false,
                          iconTheme: IconThemeData(color: Colors.white),
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        bottomNavigationBarTheme:
                            const BottomNavigationBarThemeData(
                              backgroundColor: Color(0xff1a1c22),
                              selectedItemColor: Color(0xff30D143),
                              unselectedItemColor: Colors.white,
                            ),
                        textTheme: ThemeData.dark().textTheme.apply(
                          bodyColor: Colors.white,
                          displayColor: Colors.white,
                        ),
                      )
                      : ThemeData.light().copyWith(
                        primaryColor: const Color(0xff30D143),
                        scaffoldBackgroundColor: const Color(0xffF5F5F7),
                        cardColor: Colors.white,
                        shadowColor: Colors.black.withAlpha(20),
                        dividerColor: Colors.black.withAlpha(10),
                        iconTheme: const IconThemeData(
                          color: Color(0xff1a1c22),
                        ),
                        appBarTheme: const AppBarTheme(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          centerTitle: false,
                          iconTheme: IconThemeData(color: Color(0xff1a1c22)),
                          titleTextStyle: TextStyle(
                            color: Color(0xff1a1c22),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        bottomNavigationBarTheme:
                            const BottomNavigationBarThemeData(
                              backgroundColor: Colors.white,
                              selectedItemColor: Color(0xff30D143),
                              unselectedItemColor: Color(0xff1a1c22),
                            ),
                        textTheme: ThemeData.light().textTheme.apply(
                          bodyColor: const Color(0xff1a1c22),
                          displayColor: const Color(0xff1a1c22),
                        ),
                      ),

              defaultTransition: Transition.cupertino,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(
                AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode,
              ),
              transitionDuration: const Duration(milliseconds: 500),
              // getPages: AppRoutes.pages,
              // initialRoute: AppRoutes.splash,
              home: const Splash(),
            );
          },
        );
      },
    );
  }
}
