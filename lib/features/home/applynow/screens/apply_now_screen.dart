import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/features/home/applynow/controller/apply_now_controller.dart';
import 'package:job_app/features/home/applynow/widgets/apply_button.dart';
import 'package:job_app/features/home/applynow/widgets/box_result_file.dart';
import 'package:job_app/features/home/applynow/widgets/box_upload_file.dart';

class ApplyNowScreen extends StatelessWidget {
  const ApplyNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApplyNowController());

    return Scaffold(
      appBar: const AppBarWidget(title: 'Apply Job'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Curriculum Vitae Section
            const Text(
              'Curriculum Vitae',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Upload Area
            Obx(
              () =>
                  controller.isFileUploaded.value
                      ? BoxResultFile(controller: controller)
                      : BoxUploadFile(controller: controller),
            ),

            const Spacer(),

            // Send Apply Button
            ApplyButton(controller: controller),
          ],
        ),
      ),
    );
  }
}
