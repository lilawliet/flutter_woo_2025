import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_woo_2025/common/index.dart';

import 'index.dart';

class SocketPage extends StatefulWidget {
  const SocketPage({super.key});

  @override
  State<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocketController>(
      init: SocketController(),
      id: "socket",
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("socket"),
            actions: [
              IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: controller.clearMessages,
                tooltip: '清空消息',
              ),
            ],
          ),
          body: SafeArea(child: _buildView(controller)),
        );
      },
    );
  }

  Widget _buildView(SocketController controller) {
    return KeyboardListener(
      focusNode: controller.focusNode,
      onKeyEvent: controller.handleKeyEvent,
      child: Column(
        children: [
          // 消息列表
          Expanded(
            child: ListView.builder(
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.messages[index]),
                );
              },
            ),
          ),
          // 输入框和发送按钮
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InputWidget(
                    controller: controller.textController,
                    placeholder: '输入消息...',
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controller.sendMessage,
                  child: const Text('发送'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
