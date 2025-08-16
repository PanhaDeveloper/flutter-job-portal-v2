import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/shared/label_between.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/auth/widgets/tab_auth.dart';
import 'package:job_app/features/home/search_result/controller/search_controller.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchResultController());
    return Scaffold(
      appBar: AppBarWidget(title: 'Search Results'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LabelBetween(
                title: "Technology",
                buttonText: "12 Jobs Available",
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Obx(
                    () => TabAuth(
                      text: "Most Recently",
                      color:
                          controller.selectedIndex.value == 0
                              ? AppColors.boldPrimary
                              : AppColors.white,
                      textColor:
                          controller.selectedIndex.value == 0
                              ? AppColors.white
                              : AppColors.textSecondary,
                      onPressed: () => controller.changeTab(0),
                      borderRadius: BorderRadius.circular(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => TabAuth(
                      text: "Most Popular",
                      color:
                          controller.selectedIndex.value == 1
                              ? AppColors.boldPrimary
                              : AppColors.white,
                      textColor:
                          controller.selectedIndex.value == 1
                              ? AppColors.white
                              : AppColors.textPrimary,
                      onPressed: () => controller.changeTab(1),
                      borderRadius: BorderRadius.circular(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
