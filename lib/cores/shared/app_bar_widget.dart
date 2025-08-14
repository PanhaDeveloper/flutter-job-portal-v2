import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/cores/shared/app_bar_icon.dart';
import 'package:quiz_app/cores/utils/device/device_utility.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final List<Widget>? actions;
  final String title;
  const AppBarWidget({
    super.key,
    this.isLeading = true,
    this.actions,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(onTap: () => Get.back(), child: AppBarIcon()),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
