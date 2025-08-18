import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/bindings/general_binding.dart';
import 'package:job_app/cores/utils/theme/theme.dart';
import 'package:job_app/locale/locale.dart';
import 'package:job_app/routes/app_pages.dart';
import 'package:job_app/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Job Portal',

      // Performance optimized transitions
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),

      // Theme configuration
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Performance optimizations
      debugShowCheckedModeBanner: false,
      enableLog: false,
      logWriterCallback: null,

      // Navigation configuration
      initialBinding: GeneralBinding(),
      initialRoute: AppRoutes.splash,
      getPages: appPages,

      // Localization
      translations: Localization(),
      locale: const Locale('km', 'KH'),
      fallbackLocale: const Locale('en', 'US'),

      // Additional performance optimizations
      smartManagement: SmartManagement.keepFactory,
      routingCallback: (routing) {
        // Optimize memory usage by disposing unnecessary controllers
        if (routing?.isBack == true) {
          // Clean up previous route if needed
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            ),
          );
        }
      },

      // Builder for global performance optimizations
      builder: (context, child) {
        return MediaQuery(
          // Optimize text scaling
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: MediaQuery.of(
              context,
            ).textScaleFactor.clamp(0.8, 1.2),
          ),
          child: ScrollConfiguration(
            behavior: const _AppScrollBehavior(),
            child: child!,
          ),
        );
      },
    );
  }
}

// Custom scroll behavior for better performance
class _AppScrollBehavior extends ScrollBehavior {
  const _AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Disable scrollbars for better performance on mobile
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Use platform-appropriate overscroll indicators
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Theme.of(context).primaryColor.withOpacity(0.3),
      child: child,
    );
  }
}
