import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:quiz_app/cores/bindings/general_binding.dart';
import 'package:quiz_app/cores/utils/theme/theme.dart';
import 'package:quiz_app/locale/locale.dart';
import 'package:quiz_app/routes/app_pages.dart';
import 'package:quiz_app/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBinding(),
      initialRoute: AppRoutes.authSuccess,
      getPages: appPages,
      translations: Localization(),
      locale: const Locale('km', 'KH'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
