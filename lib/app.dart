import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:job_app/cores/bindings/general_binding.dart';
import 'package:job_app/cores/utils/theme/theme.dart';
import 'package:job_app/features/home/accounts/screens/personal_profile_screen.dart';
import 'package:job_app/features/home/jobdetail/screens/job_detail_screen.dart';
import 'package:job_app/features/home/search_result/screens/search_result_screen.dart';
import 'package:job_app/locale/locale.dart';
import 'package:job_app/navigate.dart';
import 'package:job_app/routes/app_pages.dart';
import 'package:job_app/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 300),
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      // initialBinding: GeneralBinding(),
      // initialRoute: AppRoutes.splash,
      getPages: appPages,
      home: AppNavigateBar(),
      translations: Localization(),
      locale: const Locale('km', 'KH'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
