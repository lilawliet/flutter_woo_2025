import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: Column(
        children: [
          // 显示
          HelloWidget(),

          // 触发
          ElevatedButton(
            onPressed: () {
              controller.onTap(DateTime.now().millisecondsSinceEpoch);
            },
            child: const Text("点击"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("login")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
