import 'package:flutter_woo_2025/pages/index.dart';
import 'package:get/get.dart';

import 'names.dart';

class RoutePages {
  // 列表
  static List<GetPage> list = [
    GetPage(
      name: RouteNames.systemLogin,
      page: () => const LoginPage(),
      // 绑定控制器
      binding: LoginBinding(),
    ),
    GetPage(name: RouteNames.systemSplash, page: () => const SplashPage()),
  ];
}
