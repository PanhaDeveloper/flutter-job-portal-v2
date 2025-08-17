import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';

enum SweetAlertType { success, warning, error }

class SweetAlert {
  static void show({
    required SweetAlertType type,
    required String title,
    String? subTitle,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
    bool barrierDismissible = false,
  }) {
    final data = _getAlertStyle(type);

    Get.dialog(
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (barrierDismissible) Get.back();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Blur overlay
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            //   child: Container(color: Colors.black.withOpacity(0.4)),
            // ),
            // Pop-up box
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animation icon
                      Lottie.asset(
                        data['animation'],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: data['color'],
                          decoration: TextDecoration.none,
                          height: 1.2,
                        ),
                      ),
                      if (subTitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          subTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.none,
                            height: 1.5,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cancelText != null)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                  if (onCancel != null) onCancel();
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: BorderSide(color: data['color']),
                                ),
                                child: Text(
                                  cancelText,
                                  style: TextStyle(color: data['color']),
                                ),
                              ),
                            ),
                          if (cancelText != null) const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                if (onConfirm != null) onConfirm();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: data['color'],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                confirmText,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Map<String, dynamic> _getAlertStyle(SweetAlertType type) {
    switch (type) {
      case SweetAlertType.success:
        return {'color': Colors.green, 'animation': Images.successAlert};
      case SweetAlertType.warning:
        return {'color': Colors.orange, 'animation': Images.warningAlert};
      case SweetAlertType.error:
        return {'color': Colors.red, 'animation': Images.errorAlert};
    }
  }
}
