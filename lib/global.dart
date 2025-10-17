import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    // 插件初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化服务
    // 初始化本地存储
    await Storage().init();

    // 初始化提示框
    Loading();

    // 初始化网络请求
    Get.put<ConfigService>(ConfigService());
    Get.put<WPHttpService>(WPHttpService());

    await ConfigService.to.init();
  }
}
