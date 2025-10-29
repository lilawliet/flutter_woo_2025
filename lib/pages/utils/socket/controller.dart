import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  SocketController();

  late IO.Socket socket;
  List<String> messages = [];

  // 输入框控制器
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  _initData() {
    socket.on('connect', (data) {
      print("Socket connected: $data");
      // 连接成功，只添加连接状态消息，不发送到服务器
      onMessage("已连接到服务器");
    });

    socket.on('chat message', (data) {
      print("Received message: $data");
      onMessage(data);
    });

    update(["socket"]);
  }

  void onMessage(String message) {
    messages.add(message);
    update(["socket"]);
  }

  void addMessage(String message) {
    socket.emit('chat message', message);
    // 立即添加本地消息，避免等待服务器回传
    // onMessage(message);
  }

  void onTap() {}

  void clearMessages() {
    messages.clear();
    update(["socket"]);
  }

  /// 发送消息
  void sendMessage() {
    final message = textController.text.trim();
    if (message.isNotEmpty) {
      addMessage(message);
      textController.clear();
    }
  }

  /// 处理键盘事件
  void handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      sendMessage();
    }
  }

  @override
  void onInit() {
    super.onInit();

    socket = IO.io(
      'http://192.168.10.10:3000',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          // .setExtraHeaders({'foo': 'bar'}) // optional
          .build(),
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    socket.disconnect();
    super.onClose();
  }
}
