import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/security/security_service.dart';

class PinSetupScreen extends StatefulWidget {
  final bool isChanging;
  
  const PinSetupScreen({super.key, this.isChanging = false});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final SecurityService _securityService = SecurityService();
  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  
  bool _isCurrentPinValid = false;
  bool _showNewPinInput = false;
  bool _showConfirmPinInput = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isChanging) {
      _showNewPinInput = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.isChanging ? 'change_pin'.tr : 'setup_pin'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                child: Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                widget.isChanging ? 'change_your_pin'.tr : 'create_your_pin'.tr,
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
                    ? 'enter_current_pin_first'.tr 
                    : 'pin_setup_description'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Current PIN Input (only for changing)
              if (widget.isChanging && !_isCurrentPinValid) ...[
                Text(
                  'enter_current_pin'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildPinInput(
                  controller: _currentPinController,
                  onCompleted: _verifyCurrentPin,
                  errorText: null,
                ),
                
                const SizedBox(height: 32),
              ],
              
              // New PIN Input
              if (_showNewPinInput) ...[
                Text(
                  widget.isChanging ? 'enter_new_pin'.tr : 'enter_your_pin'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildPinInput(
                  controller: _newPinController,
                  onCompleted: _onNewPinCompleted,
                  errorText: null,
                ),
                
                const SizedBox(height: 32),
              ],
              
              // Confirm PIN Input
              if (_showConfirmPinInput) ...[
                Text(
                  'confirm_your_pin'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildPinInput(
                  controller: _confirmPinController,
                  onCompleted: _onConfirmPinCompleted,
                  errorText: null,
                ),
              ],
              
              const SizedBox(height: 40),
              
              // PIN Requirements
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
                          'pin_requirements'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'pin_requirements_description'.tr,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput({
    required TextEditingController controller,
    required Function(String) onCompleted,
    String? errorText,
  }) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primary.withOpacity(0.1),
        border: Border.all(color: AppColors.primary),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red, width: 2),
    );

    return Column(
      children: [
        Pinput(
          controller: controller,
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: onCompleted,
          obscureText: true,
          obscuringCharacter: '●',
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  void _verifyCurrentPin(String pin) {
    if (_securityService.verifyPin(pin)) {
      setState(() {
        _isCurrentPinValid = true;
        _showNewPinInput = true;
      });
      _currentPinController.clear();
    } else {
      Get.snackbar(
        'error'.tr,
        'incorrect_current_pin'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _currentPinController.clear();
    }
  }

  void _onNewPinCompleted(String pin) {
    if (pin.length == 6) {
      setState(() {
        _showConfirmPinInput = true;
      });
    }
  }

  void _onConfirmPinCompleted(String pin) async {
    if (_newPinController.text == pin) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (widget.isChanging) {
          final success = await _securityService.changeSecurityCredential(
            _currentPinController.text,
            pin,
          );
          if (success) {
            _showSuccessAndGoBack('pin_changed_successfully'.tr);
          } else {
            _showError('failed_to_change_pin'.tr);
          }
        } else {
          await _securityService.setPinSecurity(pin);
          _showSuccessAndGoBack('pin_setup_successfully'.tr);
        }
      } catch (e) {
        _showError('something_went_wrong'.tr);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Get.snackbar(
        'error'.tr,
        'pins_do_not_match'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _confirmPinController.clear();
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
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }
}
