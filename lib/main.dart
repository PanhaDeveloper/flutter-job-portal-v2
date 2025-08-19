import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_app/app.dart';
import 'package:job_app/cores/repo/general_repo.dart';
import 'package:job_app/cores/utils/performance/performance_monitor.dart';
import 'package:job_app/cores/utils/performance/performance_config.dart';
import 'package:job_app/cores/utils/security/app_lifecycle_manager.dart';
import 'package:job_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Performance optimizations
  _performanceOptimizations();

  // Initialize performance monitoring and config
  PerformanceMonitor.initialize();
  PerformanceConfig.initializePerformanceOptimizations();

  // System UI configuration
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations for better UX
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize storage
  await GetStorage.init();

  // Initialize security lifecycle manager
  final appLifecycleManager = AppLifecycleManager();
  appLifecycleManager.initialize();

  Get.put(GeneralRepo());

  runApp(const App());
}

void _performanceOptimizations() {
  // Enable better repaint boundary detection
  if (kDebugMode) {
    debugRepaintRainbowEnabled = false;
  }

  // Enable image cache optimization
  PaintingBinding.instance.imageCache.maximumSize = 200;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20; // 100MB

  // Reduce unnecessary rebuilds
  WidgetsBinding.instance.renderViewElement?.markNeedsBuild();
}
