import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/security/security_service.dart';
import 'package:job_app/features/security/screens/app_lock_screen.dart';

class AppLifecycleManager extends WidgetsBindingObserver {
  final SecurityService _securityService = SecurityService();
  DateTime? _backgroundTime;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _backgroundTime = DateTime.now();
        break;
      case AppLifecycleState.resumed:
        _handleAppResumed();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void _handleAppResumed() {
    if (!_securityService.isSecurityEnabled()) return;

    // Check if app was in background for too long
    if (_backgroundTime != null) {
      final timeDiff = DateTime.now().difference(_backgroundTime!).inMilliseconds;
      final autoLockTimeout = _securityService.getAutoLockTimeout();
      
      if (timeDiff > autoLockTimeout) {
        _securityService.lockApp();
      }
    }

    // Show lock screen if app is locked
    if (_securityService.isAppLocked()) {
      _showLockScreen();
    }
  }

  void _showLockScreen() {
    // Check if lock screen is not already showing
    if (Get.currentRoute != '/app-lock') {
      Get.to(
        () => const AppLockScreen(),
        routeName: '/app-lock',
        preventDuplicates: true,
      );
    }
  }

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
