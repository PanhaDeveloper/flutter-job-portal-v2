import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final slideCurrentIndex = 0.obs;
  final jobCategoryIndex = 0.obs;
  final locale = Locale('en', 'US').obs;

  final CarouselSliderController carouselController =
      CarouselSliderController();

  void changeLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
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
          'title': "Flutter Developer",
          'salary': "\$250-\$400",
          'jobType': 'Fulltime, remote/onsite',
          'companyName': "BELTEI",
          'companyLogo': Images.cardLogo1,
        },
        {
          'title': "React Developer",
          'salary': "\$300-\$500",
          'jobType': 'Part-time, onsite',
          'companyName': "TechCorp",
          'companyLogo': Images.cardLogo1,
        },
        {
          'title': "Flutter Developer",
          'salary': "\$250-\$400",
          'jobType': 'Fulltime, remote/onsite',
          'companyName': "BELTEI",
          'companyLogo': Images.cardLogo1,
        },
        {
          'title': "React Developer",
          'salary': "\$300-\$500",
          'jobType': 'Part-time, onsite',
          'companyName': "TechCorp",
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
          'title': "Java Developer",
          'salary': "\$500-\$700",
          'jobType': 'Fulltime, remote',
          'companyName': "GlobalSoft",
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
