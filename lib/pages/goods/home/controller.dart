import 'package:flutter_woo_2025/common/index.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  // 导航点击事件
  void onAppBarTap() {}

  // Banner 当前位置
  int bannerCurrentIndex = 0;

  // Banner 数据
  List<KeyValueModel> bannerItems = [];

  // Banner 切换事件
  void onChangeBanner(int index, /*CarouselPageChangedReason*/ reason) {
    bannerCurrentIndex = index;
    update(["home_banner"]);
  }

  _initData() async {
    // 首页
    // banner
    bannerItems = await SystemApi.banners();

    update(["home"]);
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
