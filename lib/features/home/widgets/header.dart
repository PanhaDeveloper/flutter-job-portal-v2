import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/cores/utils/constants/ui_constants.dart';
import 'package:job_app/features/home/controller/home_controller.dart';
import 'package:job_app/routes/app_routes.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  Images.profileImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              UIConstants.sizedBoxWidth10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'good_morning'.tr,
                      style: UIConstants.textStyle14Secondary,
                      overflow: TextOverflow.ellipsis,
                    ),
                    UIConstants.sizedBoxHeight2,
                    const Text(
                      'Username',
                      style: UIConstants.textStyle18BoldBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'select_language'.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListTile(
                            leading: Image.asset(
                              Images.khFlag,
                              width: 24,
                              height: 24,
                            ),
                            title: Text('km'.tr),
                            onTap: () {
                              HomeController.instance.changeLocale(
                                const Locale('km', 'KH'),
                              );
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: Image.asset(
                              Images.usFlag,
                              width: 24,
                              height: 24,
                            ),
                            title: Text('en'.tr),
                            onTap: () {
                              HomeController.instance.changeLocale(
                                const Locale('en', 'US'),
                              );
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: Image.asset(
                              Images.cnFlag,
                              width: 24,
                              height: 24,
                            ),
                            title: Text('zh'.tr),
                            onTap: () {
                              HomeController.instance.changeLocale(
                                const Locale('zh', 'CN'),
                              );
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Obx(() {
                  final locale = HomeController.instance.locale.value;
                  final flagImage =
                      locale.languageCode == 'km'
                          ? Images.khFlag
                          : locale.languageCode == 'zh'
                          ? Images.cnFlag
                          : Images.usFlag;
                  return Image.asset(flagImage, width: 24, height: 24);
                }),
              ),
              const SizedBox(width: 10),
              Stack(
                children: [
                  GestureDetector(
                    child: const Icon(
                      Iconsax.notification,
                      size: 28,
                      color: Colors.black54,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.notification),
                  ),
                  Positioned(
                    right: 3,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
