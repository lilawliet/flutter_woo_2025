import 'package:flutter_woo_2025/common/index.dart';
import 'package:flutter_woo_2025/pages/index.dart';
import 'package:get/get.dart';

class MyIndexController extends GetxController {
  MyIndexController();

  _initData() {
    update(["my_index"]);
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
  }

  // 注销
  void onLogout() {
    UserService.to.logout();
    Get.find<MainController>().onJumpToPage(0);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
