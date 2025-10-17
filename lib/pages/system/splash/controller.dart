import 'package:flutter_woo_2025/common/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  String title = "";

  _jumpToPage() {
    // 欢迎页
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(RouteNames.systemWelcome);
    });
  }

  _initData() {
    update(["splash"]);
  }

  void onTap(int ticket) {
    title = "GetBuilder => 点击了第 $ticket 个按钮";
    update(["splash_title"]);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    // _initData(); // 初始数据
    _jumpToPage(); // 跳转界面
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
