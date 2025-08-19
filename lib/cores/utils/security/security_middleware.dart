import 'package:get/get.dart';
import 'package:job_app/cores/utils/security/security_service.dart';
import 'package:job_app/features/security/screens/app_lock_screen.dart';
import 'package:job_app/routes/app_routes.dart';

class SecurityMiddleware extends GetMiddleware {
  final SecurityService _securityService = SecurityService();

  @override
  GetPage? onPageCalled(GetPage? page) {
    // Skip security check for app lock screen itself and splash screen
    if (page?.name == AppRoutes.appLock || 
        page?.name == AppRoutes.splash ||
        page?.name == AppRoutes.onboarding ||
        page?.name == AppRoutes.auth) {
      return page;
    }

    // Check if app security is enabled and app should be locked
    if (_securityService.isSecurityEnabled()) {
      _securityService.checkAutoLock();
      
      if (_securityService.isAppLocked()) {
        // Redirect to app lock screen instead of the requested page
        return GetPage(
          name: AppRoutes.appLock,
          page: () => const AppLockScreen(),
        );
      }
    }
    
    return page;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    // Update last authentication time when user navigates (app is active)
    if (_securityService.isSecurityEnabled() && !_securityService.isAppLocked()) {
      _securityService.updateLastAuthTime();
    }
    
    return page;
  }
}
