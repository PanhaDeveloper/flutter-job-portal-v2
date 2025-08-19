import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/security/security_service.dart';
import 'package:job_app/features/security/screens/pin_setup_screen.dart';
import 'package:job_app/features/security/screens/password_setup_screen.dart';

class SecuritySetupScreen extends StatefulWidget {
  const SecuritySetupScreen({super.key});

  @override
  State<SecuritySetupScreen> createState() => _SecuritySetupScreenState();
}

class _SecuritySetupScreenState extends State<SecuritySetupScreen> {
  final SecurityService _securityService = SecurityService();
  late SecurityType currentSecurityType;

  @override
  void initState() {
    super.initState();
    currentSecurityType = _securityService.getSecurityType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'app_security'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Status
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: currentSecurityType != SecurityType.none 
                      ? Colors.green.shade50 
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: currentSecurityType != SecurityType.none 
                        ? Colors.green.shade200 
                        : Colors.orange.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      currentSecurityType != SecurityType.none 
                          ? Iconsax.shield_tick 
                          : Iconsax.shield_cross,
                      color: currentSecurityType != SecurityType.none 
                          ? Colors.green 
                          : Colors.orange,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSecurityType != SecurityType.none 
                                ? 'security_enabled'.tr 
                                : 'security_disabled'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentSecurityType != SecurityType.none 
                                ? '${'current_security_type'.tr}: ${_securityService.getSecurityTypeDisplayName()}'
                                : 'security_disabled_description'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Security Options
              Text(
                'security_options'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // PIN Option
              _buildSecurityOption(
                icon: Iconsax.key,
                title: 'pin_security'.tr,
                description: 'pin_security_description'.tr,
                isSelected: currentSecurityType == SecurityType.pin,
                onTap: () => _showPinSetup(),
              ),

              const SizedBox(height: 12),

              // Password Option
              _buildSecurityOption(
                icon: Iconsax.password_check,
                title: 'password_security'.tr,
                description: 'password_security_description'.tr,
                isSelected: currentSecurityType == SecurityType.password,
                onTap: () => _showPasswordSetup(),
              ),

              const SizedBox(height: 12),

              // No Security Option
              _buildSecurityOption(
                icon: Iconsax.shield_cross,
                title: 'no_security'.tr,
                description: 'no_security_description'.tr,
                isSelected: currentSecurityType == SecurityType.none,
                onTap: () => _disableSecurity(),
              ),

              if (currentSecurityType != SecurityType.none) ...[
                const SizedBox(height: 24),
                
                // Change Security
                Text(
                  'security_management'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Change Security Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _changeExistingSecurity(),
                    icon: const Icon(Iconsax.edit, color: Colors.white),
                    label: Text('change_security'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.primary : Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: isSelected 
            ? const Icon(Iconsax.tick_circle, color: AppColors.primary)
            : Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _showPinSetup() {
    Get.to(() => const PinSetupScreen())?.then((_) => _refreshSecurityType());
  }

  void _showPasswordSetup() {
    Get.to(() => const PasswordSetupScreen())?.then((_) => _refreshSecurityType());
  }

  void _disableSecurity() {
    if (currentSecurityType == SecurityType.none) return;

    Get.dialog(
      AlertDialog(
        title: Text('disable_security'.tr),
        content: Text('disable_security_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              await _securityService.removeSecurity();
              Get.back();
              _refreshSecurityType();
              Get.snackbar(
                'success'.tr,
                'security_disabled_successfully'.tr,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: Text('disable'.tr, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _changeExistingSecurity() {
    final securityType = _securityService.getSecurityType();
    switch (securityType) {
      case SecurityType.pin:
        Get.to(() => const PinSetupScreen(isChanging: true))?.then((_) => _refreshSecurityType());
        break;
      case SecurityType.password:
        Get.to(() => const PasswordSetupScreen(isChanging: true))?.then((_) => _refreshSecurityType());
        break;
      case SecurityType.none:
        break;
    }
  }

  void _refreshSecurityType() {
    setState(() {
      currentSecurityType = _securityService.getSecurityType();
    });
  }
}
