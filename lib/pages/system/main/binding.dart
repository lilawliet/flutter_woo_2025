import 'package:flutter_woo_2025/pages/index.dart';
import 'package:get/get.dart';

/// 主界面依赖
class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartIndexController>(() => CartIndexController());
    Get.lazyPut<MsgController>(() => MsgController());
    Get.lazyPut<MyIndexController>(() => MyIndexController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
