import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/security/security_service.dart';

class PasswordSetupScreen extends StatefulWidget {
  final bool isChanging;
  
  const PasswordSetupScreen({super.key, this.isChanging = false});

  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  final SecurityService _securityService = SecurityService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.isChanging ? 'change_password'.tr : 'setup_password'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.password_check,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  widget.isChanging ? 'change_your_password'.tr : 'create_your_password'.tr,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 12),
                
                // Description
                Text(
                  widget.isChanging 
                      ? 'enter_current_password_first'.tr 
                      : 'password_setup_description'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // Current Password (only for changing)
                if (widget.isChanging) ...[
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: 'current_password'.tr,
                    hint: 'enter_current_password'.tr,
                    isPassword: !_showCurrentPassword,
                    onVisibilityToggle: () => setState(() => _showCurrentPassword = !_showCurrentPassword),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'current_password_required'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                ],
                
                // New Password
                _buildPasswordField(
                  controller: _newPasswordController,
                  label: widget.isChanging ? 'new_password'.tr : 'password'.tr,
                  hint: widget.isChanging ? 'enter_new_password'.tr : 'enter_password'.tr,
                  isPassword: !_showNewPassword,
                  onVisibilityToggle: () => setState(() => _showNewPassword = !_showNewPassword),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password_required'.tr;
                    }
                    if (value.length < 8) {
                      return 'password_min_length'.tr;
                    }
                    if (!_hasUppercase(value)) {
                      return 'password_uppercase_required'.tr;
                    }
                    if (!_hasLowercase(value)) {
                      return 'password_lowercase_required'.tr;
                    }
                    if (!_hasDigit(value)) {
                      return 'password_digit_required'.tr;
                    }
                    if (!_hasSpecialChar(value)) {
                      return 'password_special_char_required'.tr;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Confirm Password
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'confirm_password'.tr,
                  hint: 'confirm_your_password'.tr,
                  isPassword: !_showConfirmPassword,
                  onVisibilityToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'confirm_password_required'.tr;
                    }
                    if (value != _newPasswordController.text) {
                      return 'passwords_do_not_match'.tr;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Password Requirements
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'password_requirements'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildRequirement('password_req_length'.tr, _newPasswordController.text.length >= 8),
                      _buildRequirement('password_req_uppercase'.tr, _hasUppercase(_newPasswordController.text)),
                      _buildRequirement('password_req_lowercase'.tr, _hasLowercase(_newPasswordController.text)),
                      _buildRequirement('password_req_digit'.tr, _hasDigit(_newPasswordController.text)),
                      _buildRequirement('password_req_special'.tr, _hasSpecialChar(_newPasswordController.text)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Setup Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _setupPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            widget.isChanging ? 'change_password'.tr : 'setup_password'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isPassword,
    required VoidCallback onVisibilityToggle,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          onChanged: (value) => setState(() {}), // To update requirements
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: IconButton(
              icon: Icon(
                isPassword ? Iconsax.eye_slash : Iconsax.eye,
                color: Colors.grey[600],
              ),
              onPressed: onVisibilityToggle,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isMet ? Colors.green : Colors.grey[600],
              fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasUppercase(String value) => value.contains(RegExp(r'[A-Z]'));
  bool _hasLowercase(String value) => value.contains(RegExp(r'[a-z]'));
  bool _hasDigit(String value) => value.contains(RegExp(r'[0-9]'));
  bool _hasSpecialChar(String value) => value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  void _setupPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.isChanging) {
        final success = await _securityService.changeSecurityCredential(
          _currentPasswordController.text,
          _newPasswordController.text,
        );
        if (success) {
          _showSuccessAndGoBack('password_changed_successfully'.tr);
        } else {
          _showError('incorrect_current_password'.tr);
        }
      } else {
        await _securityService.setPasswordSecurity(_newPasswordController.text);
        _showSuccessAndGoBack('password_setup_successfully'.tr);
      }
    } catch (e) {
      _showError('something_went_wrong'.tr);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessAndGoBack(String message) {
    Get.snackbar(
      'success'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.back();
  }

  void _showError(String message) {
    Get.snackbar(
      'error'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
