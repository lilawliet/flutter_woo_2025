import 'package:flutter_woo_2025/common/index.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainController();

  _initData() async {
    // 读取用户 profile
    await UserService.to.getProfile();

    update(["main"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();

    // 跳转注册页
    Get.toNamed(RouteNames.systemRegister);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
