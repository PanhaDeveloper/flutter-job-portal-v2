import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'welcome': 'Welcome',
      'login': 'Login',
      'signup': 'Sign Up',
      'logout': 'Logout',
    },
    'km_KH': {
      'welcome': 'សូមស្វាគមន៍',
      'login': 'ចូលគណនី',
      'signup': 'ចុះឈ្មោះ',
      'logout': 'ចាកចេញ',
    },
    'zh_CN': {'welcome': '欢迎', 'login': '登录', 'signup': '注册', 'logout': '退出登录'},
  };
}
