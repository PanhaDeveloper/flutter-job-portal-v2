import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get_storage/get_storage.dart';

enum SecurityType { none, pin, password }

class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();

  final _storage = GetStorage();
  
  // Storage keys
  static const String _securityTypeKey = 'security_type';
  static const String _securityCredentialKey = 'security_credential';
  static const String _isAppLockedKey = 'is_app_locked';
  static const String _lastAuthTimeKey = 'last_auth_time';
  static const String _autoLockTimeoutKey = 'auto_lock_timeout';

  // Default auto-lock timeout (5 minutes)
  static const int defaultAutoLockTimeout = 5 * 60 * 1000; // 5 minutes in milliseconds

  /// Get current security type
  SecurityType getSecurityType() {
    final typeIndex = _storage.read<int>(_securityTypeKey) ?? 0;
    return SecurityType.values[typeIndex];
  }

  /// Set security type
  Future<void> setSecurityType(SecurityType type) async {
    await _storage.write(_securityTypeKey, type.index);
  }

  /// Check if app security is enabled
  bool isSecurityEnabled() {
    return getSecurityType() != SecurityType.none;
  }

  /// Hash the credential using SHA-256
  String _hashCredential(String credential) {
    var bytes = utf8.encode(credential);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Set PIN security
  Future<void> setPinSecurity(String pin) async {
    await setSecurityType(SecurityType.pin);
    await _storage.write(_securityCredentialKey, _hashCredential(pin));
    await setAppLocked(false); // Unlock after setting up
  }

  /// Set Password security
  Future<void> setPasswordSecurity(String password) async {
    await setSecurityType(SecurityType.password);
    await _storage.write(_securityCredentialKey, _hashCredential(password));
    await setAppLocked(false); // Unlock after setting up
  }

  /// Verify PIN
  bool verifyPin(String pin) {
    if (getSecurityType() != SecurityType.pin) return false;
    final storedHash = _storage.read<String>(_securityCredentialKey);
    return storedHash == _hashCredential(pin);
  }

  /// Verify Password
  bool verifyPassword(String password) {
    if (getSecurityType() != SecurityType.password) return false;
    final storedHash = _storage.read<String>(_securityCredentialKey);
    return storedHash == _hashCredential(password);
  }

  /// Authenticate with credential
  bool authenticate(String credential) {
    final securityType = getSecurityType();
    switch (securityType) {
      case SecurityType.pin:
        return verifyPin(credential);
      case SecurityType.password:
        return verifyPassword(credential);
      case SecurityType.none:
        return true;
    }
  }

  /// Remove security (disable app lock)
  Future<void> removeSecurity() async {
    await setSecurityType(SecurityType.none);
    await _storage.remove(_securityCredentialKey);
    await setAppLocked(false);
  }

  /// Check if app is currently locked
  bool isAppLocked() {
    if (!isSecurityEnabled()) return false;
    return _storage.read<bool>(_isAppLockedKey) ?? false;
  }

  /// Set app lock status
  Future<void> setAppLocked(bool locked) async {
    await _storage.write(_isAppLockedKey, locked);
    if (!locked) {
      // Update last authentication time when unlocking
      await _storage.write(_lastAuthTimeKey, DateTime.now().millisecondsSinceEpoch);
    }
  }

  /// Lock the app
  Future<void> lockApp() async {
    if (isSecurityEnabled()) {
      await setAppLocked(true);
    }
  }

  /// Check if app should be auto-locked based on timeout
  bool shouldAutoLock() {
    if (!isSecurityEnabled()) return false;
    
    final lastAuthTime = _storage.read<int>(_lastAuthTimeKey);
    if (lastAuthTime == null) return true;
    
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeout = getAutoLockTimeout();
    
    return (currentTime - lastAuthTime) > timeout;
  }

  /// Get auto-lock timeout in milliseconds
  int getAutoLockTimeout() {
    return _storage.read<int>(_autoLockTimeoutKey) ?? defaultAutoLockTimeout;
  }

  /// Set auto-lock timeout in milliseconds
  Future<void> setAutoLockTimeout(int timeoutMs) async {
    await _storage.write(_autoLockTimeoutKey, timeoutMs);
  }

  /// Update last authentication time
  Future<void> updateLastAuthTime() async {
    await _storage.write(_lastAuthTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// Check and apply auto-lock if needed
  Future<void> checkAutoLock() async {
    if (shouldAutoLock()) {
      await lockApp();
    }
  }

  /// Change existing security credential
  Future<bool> changeSecurityCredential(String currentCredential, String newCredential) async {
    if (!authenticate(currentCredential)) {
      return false; // Current credential is incorrect
    }

    final securityType = getSecurityType();
    switch (securityType) {
      case SecurityType.pin:
        await setPinSecurity(newCredential);
        break;
      case SecurityType.password:
        await setPasswordSecurity(newCredential);
        break;
      case SecurityType.none:
        return false; // No security enabled
    }
    
    return true;
  }

  /// Get security type display name
  String getSecurityTypeDisplayName() {
    switch (getSecurityType()) {
      case SecurityType.pin:
        return 'PIN';
      case SecurityType.password:
        return 'Password';
      case SecurityType.none:
        return 'None';
    }
  }
}
