import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/features/home/applynow/controller/apply_now_controller.dart';

class PreviewPdfScreen extends StatelessWidget {
  final controller = ApplyNowController.instance;

  PreviewPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Preview'),
      body: Obx(
        () => Stack(
          children: [
            PDFView(
              filePath: controller.filePath.value,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onRender: (pages) {
                controller.isPreviewing.value = false; // ✅ stop loading
              },
              onError: (error) {
                controller.isPreviewing.value = false;
                print(error.toString());
              },
              onPageError: (page, error) {
                controller.isPreviewing.value = false;
                print('$page: ${error.toString()}');
              },
            ),
            if (controller.isPreviewing.value)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
