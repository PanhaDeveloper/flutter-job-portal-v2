import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final slideCurrentIndex = 0.obs;
  final jobCategoryIndex = 0.obs;
  final locale = const Locale('en', 'US').obs;
  final storage = GetStorage();

  // Loading states for different sections
  final isLoadingSlider = true.obs;
  final isLoadingJobs = true.obs;
  final isLoadingProfile = true.obs;

  var jobLocation = 'Phnom Penh, Cambodia'.obs;
  var workInterest = 'Graphic & Design'.obs;
  var selectedRoles = <String>[].obs;
  var salaryRange = const RangeValues(250, 300).obs;
  var categories =
      {
        'full_time'.tr: true,
        'part_time'.tr: false,
        'freelance'.tr: false,
        'remote'.tr: false,
        'internship'.tr: false,
      }.obs;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    final savedLocale = storage.read('locale');
    if (savedLocale != null) {
      final parts = savedLocale.split('_'); // "en_US" => ['en', 'US']
      locale.value = Locale(parts[0], parts[1]);
    }

    // Simulate loading data
    _loadInitialData();
  }

  /// Simulates loading initial data with delays to show shimmer effects
  Future<void> _loadInitialData() async {
    // Simulate profile loading (fastest)
    await Future.delayed(const Duration(milliseconds: 800));
    isLoadingProfile.value = false;

    // Simulate slider data loading
    await Future.delayed(const Duration(milliseconds: 500));
    isLoadingSlider.value = false;

    // Simulate jobs data loading (slowest)
    await Future.delayed(const Duration(milliseconds: 1200));
    isLoadingJobs.value = false;
  }

  /// Method to refresh all data
  Future<void> refreshData() async {
    isLoadingSlider.value = true;
    isLoadingJobs.value = true;
    isLoadingProfile.value = true;

    await _loadInitialData();
  }

  void changeLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    storage.write(
      'locale',
      '${newLocale.languageCode}_${newLocale.countryCode}',
    );
  }

  void updateSlideIndex(int index) {
    slideCurrentIndex.value = index;
  }

  void moveCarouselBaseOnDotClicked(int index) {
    carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, dynamic>> tabHomeData = [
    {
      'text': 'All Jobs',
      'backgroundColor': Colors.blue,
      'textColor': Colors.white,
      'content': [
        {
          'title': 'Flutter Developer',
          'salary': '\$250-\$400',
          'jobType': 'Fulltime, remote/onsite',
          'companyName': 'BELTEI',
          'companyLogo': Images.cardLogo1,
        },
        {
          'title': 'React Developer',
          'salary': '\$300-\$500',
          'jobType': 'Part-time, onsite',
          'companyName': 'TechCorp',
          'companyLogo': Images.cardLogo1,
        },
        {
          'title': 'Flutter Developer',
          'salary': '\$250-\$400',
          'jobType': 'Fulltime, remote/onsite',
          'companyName': 'BELTEI',
          'companyLogo': Images.cardLogo1,
        },
        {
          'title': 'React Developer',
          'salary': '\$300-\$500',
          'jobType': 'Part-time, onsite',
          'companyName': 'TechCorp',
          'companyLogo': Images.cardLogo1,
        },
      ],
    },
    {
      'text': 'Design',
      'backgroundColor': Colors.white,
      'textColor': Colors.blue,
      'content': [
        {
          'title': 'Java Developer',
          'salary': '\$500-\$700',
          'jobType': 'Fulltime, remote',
          'companyName': 'GlobalSoft',
          'companyLogo': Images.cardLogo1,
        },
      ],
    },
    {
      'text': 'Project Management',
      'backgroundColor': Colors.white,
      'textColor': Colors.blue,
      'content': [],
    },
  ];

  void updateJobCategoryIndex(int index) {
    jobCategoryIndex.value = index;
  }
}
