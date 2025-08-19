import 'package:get/get.dart';
import 'package:job_app/cores/utils/security/security_service.dart';

class SecurityController extends GetxController {
  final SecurityService _securityService = SecurityService();
  
  // Observable properties
  final RxBool isSecurityEnabled = false.obs;
  final Rx<SecurityType> currentSecurityType = SecurityType.none.obs;
  final RxString securityTypeDisplayName = 'None'.obs;

  @override
  void onInit() {
    super.onInit();
    _updateSecurityStatus();
  }

  void _updateSecurityStatus() {
    isSecurityEnabled.value = _securityService.isSecurityEnabled();
    currentSecurityType.value = _securityService.getSecurityType();
    securityTypeDisplayName.value = _securityService.getSecurityTypeDisplayName();
  }

  Future<void> refreshSecurityStatus() async {
    _updateSecurityStatus();
  }

  Future<void> disableSecurity() async {
    await _securityService.removeSecurity();
    _updateSecurityStatus();
  }

  Future<void> lockApp() async {
    await _securityService.lockApp();
  }

  bool verifyCredential(String credential) {
    return _securityService.authenticate(credential);
  }

  Future<void> unlockApp() async {
    await _securityService.setAppLocked(false);
    await _securityService.updateLastAuthTime();
  }
}
