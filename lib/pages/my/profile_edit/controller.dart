import 'package:flutter/material.dart';
import 'package:flutter_woo_2025/common/index.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ProfileEditController extends GetxController {
  ProfileEditController();

  // 头像图片
  AssetEntity? userPhoto;

  // 选取照片
  void onSelectPhoto() {
    BottomSheetWidget.show(
      context: Get.context!,
      titleString: "Select photo",
      padding: 20,
      content: PickerImageWidget(
        // 拍照
        onTapTake: (AssetEntity? result) async {
          if (result != null) {
            userPhoto = result;
            update(["profile_edit"]);
          }
        },
        // 相册
        onTapAlbum: (List<AssetEntity>? result) async {
          if (result != null && result.isNotEmpty) {
            userPhoto = result.first;
            update(["profile_edit"]);
          }
        },
      ),
    );
  }

  // 表单 form
  GlobalKey formKey = GlobalKey<FormState>();

  // 输入框控制器
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  // 初始数据_
  _initData() {
    // 用户 profile
    UserProfileModel profile = UserService.to.profile;

    // 初始值
    firstNameController.text = profile.firstName ?? "";
    lastNameController.text = profile.lastName ?? "";
    emailController.text = profile.email ?? "";
    update(["profile_edit"]);
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

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
