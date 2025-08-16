import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:job_app/cores/utils/constants/colors.dart";
import "package:job_app/cores/utils/constants/image_strings.dart";
import "package:job_app/features/home/controller/home_controller.dart";
import "package:job_app/routes/app_routes.dart";

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Good Morning",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Username",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Select Language",
                          style: TextStyle(
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
                          title: Text("Khmer"),
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
                          title: Text("English"),
                          onTap: () {
                            HomeController.instance.changeLocale(
                              const Locale('en', 'US'),
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
                    locale.languageCode == 'km' ? Images.khFlag : Images.usFlag;
                return Image.asset(flagImage, width: 24, height: 24);
              }),
            ),
            SizedBox(width: 10),
            Stack(
              children: [
                InkWell(
                  child: Icon(
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
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
