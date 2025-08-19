import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/auth/widgets/auth_panel_widget.dart';
import 'package:job_app/features/auth/widgets/login_widget.dart';
import 'package:job_app/features/auth/widgets/register_widget.dart';
import 'package:job_app/features/auth/widgets/tab_auth.dart';
import 'package:job_app/features/auth/controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key}) {
    Get.put(AuthController());
  }
  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;

    return Scaffold(
      backgroundColor: AppColors.boldPrimary,
      body: SafeArea(
        child: Obx(
          () => AuthPanelWidget(
            widget: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.boldPrimary, width: 1),
              ),
              child: Row(
                children: [
                  TabAuth(
                    text: 'Login',
                    textColor:
                        controller.isLogin
                            ? AppColors.white
                            : AppColors.boldPrimary,
                    color:
                        controller.isLogin
                            ? AppColors.boldPrimary
                            : AppColors.white,
                    onPressed: () => controller.changeTab(AuthTab.login),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  TabAuth(
                    text: 'Register',
                    textColor:
                        !controller.isLogin
                            ? AppColors.white
                            : AppColors.boldPrimary,
                    color:
                        !controller.isLogin
                            ? AppColors.boldPrimary
                            : AppColors.white,
                    onPressed: () => controller.changeTab(AuthTab.register),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ],
              ),
            ),
            sizeBox: 20,
            content: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  controller.isLogin
                      ? const LoginWidget()
                      : const RegisterWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
