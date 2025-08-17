import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/auth/widgets/tab_auth.dart';
import 'package:job_app/features/home/jobdetail/controller/job_detail_controller.dart';

class JobTab extends StatelessWidget {
  const JobTab({super.key, required this.controller});

  final JobDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => TabAuth(
            text: 'description'.tr,
            textColor:
                controller.selectedIndex.value == 0
                    ? AppColors.white
                    : AppColors.textSecondary,
            color:
                controller.selectedIndex.value == 0
                    ? AppColors.boldPrimary
                    : Colors.white,
            onPressed: () => controller.changeTab(0),
            borderRadius: BorderRadius.circular(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Obx(
          () => TabAuth(
            text: 'company'.tr,
            textColor:
                controller.selectedIndex.value == 1
                    ? AppColors.white
                    : AppColors.textSecondary,
            color:
                controller.selectedIndex.value == 1
                    ? AppColors.boldPrimary
                    : Colors.white,
            onPressed: () => controller.changeTab(1),
            borderRadius: BorderRadius.circular(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Obx(
          () => TabAuth(
            text: 'review'.tr,
            textColor:
                controller.selectedIndex.value == 2
                    ? AppColors.white
                    : AppColors.textSecondary,
            color:
                controller.selectedIndex.value == 2
                    ? AppColors.boldPrimary
                    : Colors.white,
            onPressed: () => controller.changeTab(2),
            borderRadius: BorderRadius.circular(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
