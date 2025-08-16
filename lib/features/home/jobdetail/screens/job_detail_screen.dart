import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/home/jobdetail/controller/job_detail_controller.dart';
import 'package:job_app/features/home/jobdetail/widgets/circle_button.dart';
import 'package:job_app/features/home/jobdetail/widgets/job_box.dart';
import 'package:job_app/features/home/jobdetail/widgets/job_tab.dart';
import 'package:job_app/features/home/jobdetail/widgets/tab_company.dart';
import 'package:job_app/features/home/jobdetail/widgets/tab_desc.dart';
import 'package:job_app/features/home/jobdetail/widgets/tab_review.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobDetailController());

    return Scaffold(
      appBar: AppBarWidget(
        title: '',
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppColors.boldPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        runSpacing: 12,
                        children: [
                          const Text(
                            "Share to",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleButton(
                                icon: Icons.facebook,
                                label: "Facebook",
                                color: Colors.blue,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              CircleButton(
                                icon: Icons.link,
                                label: "Copy Link",
                                color: Colors.grey,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              CircleButton(
                                icon: Icons.message,
                                label: "Messenger",
                                color: Colors.blueAccent,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              CircleButton(
                                icon: Icons.telegram,
                                label: "Telegram",
                                color: Colors.lightBlue,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Icon(Icons.share, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JobBox(
              logoTitle: 'gojek',
              jobTitle: 'Software Engineer',
              companyLocation: 'Gojek • Jakarta Indonesia',
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  JobTab(controller: controller),
                  const SizedBox(height: 20),
                  Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      transitionBuilder:
                          (child, animation) => SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                      child:
                          controller.selectedIndex.value == 0
                              ? const TabDescription(key: ValueKey('desc'))
                              : controller.selectedIndex.value == 1
                              ? const TabCompany(key: ValueKey('company'))
                              : const TabReview(key: ValueKey('review')),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: AppColors.boldPrimary,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boldPrimary,
                ),
                child: const Text('Apply Now', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
