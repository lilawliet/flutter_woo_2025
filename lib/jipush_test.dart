import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:jpush_flutter/jpush_interface.dart';

import 'common/index.dart';
import 'global.dart';

void main() async {
  // 先执行依赖注入 初始化全局服务，再执行runApp
  await Global.init();

  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String? debugLable = 'Unknown';
  final JPushFlutterInterface jpush = JPush.newJPush();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;

    try {
      jpush.setCallBackHarmony((eventName, data) async {
        print("flutter_log_MyApp:eventName:$eventName");
        print("flutter_log_MyApp:data:$data");
        setState(() {
          print("flutter_log_MyApp:setState");
          debugLable = "flutter CallBackHarmony: $eventName:$data";
        });
      });

      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          setState(() {
            debugLable = "flutter onReceiveNotification: $message";
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLable = "flutter onReceiveMessage: $message";
          });
        },
        onReceiveNotificationAuthorization:
            (Map<String, dynamic> message) async {
              print("flutter onReceiveNotificationAuthorization: $message");
              setState(() {
                debugLable =
                    "flutter onReceiveNotificationAuthorization: $message";
              });
            },
        onNotifyMessageUnShow: (Map<String, dynamic> message) async {
          print("flutter onNotifyMessageUnShow: $message");
          setState(() {
            debugLable = "flutter onNotifyMessageUnShow: $message";
          });
        },
        onInAppMessageShow: (Map<String, dynamic> message) async {
          print("flutter onInAppMessageShow: $message");
          setState(() {
            debugLable = "flutter onInAppMessageShow: $message";
          });
        },
        onCommandResult: (Map<String, dynamic> message) async {
          print("flutter onCommandResult: $message");
          setState(() {
            debugLable = "flutter onCommandResult: $message";
          });
        },
        onInAppMessageClick: (Map<String, dynamic> message) async {
          print("flutter onInAppMessageClick: $message");
          setState(() {
            debugLable = "flutter onInAppMessageClick: $message";
          });
        },
        onNotifyButtonClick: (Map<String, dynamic> message) async {
          print("flutter onNotifyButtonClick: $message");
          setState(() {
            debugLable = "flutter onNotifyButtonClick: $message";
          });
        },
        onConnected: (Map<String, dynamic> message) async {
          print("flutter onConnected: $message");
          setState(() {
            debugLable = "flutter onConnected: $message";
          });
        },
        onReceiveDeviceToken: (Map<String, dynamic> message) async {
          print("flutter onReceiveDeviceToken: $message");
          setState(() {
            debugLable = "flutter onReceiveDeviceToken: $message";
          });
        },
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    jpush.setAuth(enable: true);
    jpush.setup(
      appKey: "b266cd5c8544ba09b23733e3", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
      NotificationSettingsIOS(sound: true, alert: true, badge: true),
    );

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    // iOS要是使用应用内消息，请在页面进入离开的时候配置pageEnterTo 和  pageLeave 函数，参数为页面名。
    jpush.pageEnterTo("HomePage"); // 在离开页面的时候请调用 jpush.pageLeave("HomePage");

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AdaptiveTheme(
  //     // 样式
  //     light: AppTheme.light, // 亮色主题
  //     dark: AppTheme.dark, // 暗色主题
  //     initial: ConfigService.to.themeMode, // 初始主题
  //     debugShowFloatingThemeButton: kDebugMode, // 显示主题按钮, 开发阶段打开, 生产阶段关闭
  //     builder: (theme, darkTheme) => ScreenUtilInit(
  //       designSize: const Size(414, 896), // 设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
  //       splitScreenMode: false, // 支持分屏尺寸
  //       minTextAdapt: false, // 是否根据宽度/高度中的最小值适配文字
  //       child: RefreshConfiguration(
  //         headerBuilder: () => const ClassicHeader(), // 自定义刷新头部
  //         footerBuilder: () => const ClassicFooter(), // 自定义刷新尾部
  //         hideFooterWhenNotFull: true, // 当列表不满一页时,是否隐藏刷新尾部
  //         headerTriggerDistance: 80, // 触发刷新的距离
  //         maxOverScrollExtent: 100, // 最大的拖动距离
  //         footerTriggerDistance: 150, // 触发加载的距离

  //         child: GetMaterialApp(
  //           title: 'Woo 2025',
  //           // 主题
  //           // theme: ThemeData(
  //           //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //           //   useMaterial3: false,
  //           // ),
  //           theme: theme,
  //           darkTheme: darkTheme,

  //           // 路由
  //           initialRoute: RouteNames.systemSplash,
  //           getPages: RoutePages.list,
  //           navigatorObservers: [RoutePages.observer],

  //           // 国际化
  //           translations: Translation(), // 词典
  //           localizationsDelegates: Translation.localizationsDelegates, // 代理
  //           supportedLocales: Translation.supportedLocales, // 支持的语言种类
  //           locale: ConfigService.to.locale, // 当前语言种类
  //           fallbackLocale: Translation.fallbackLocale, // 默认语言种类
  //           // 设备预览
  //           // locale: DevicePreview.locale(context),
  //           // builder: DevicePreview.appBuilder,
  //           builder: (context, widget) {
  //             // EasyLoading 初始化
  //             widget = EasyLoading.init()(context, widget);

  //             // 不随系统字体缩放比例
  //             return MediaQuery(
  //               data: MediaQuery.of(
  //                 context,
  //               ).copyWith(textScaler: const TextScaler.linear(1.0)),
  //               child: widget,
  //             );
  //           },

  //           // 调试标志
  //           debugShowCheckedModeBanner: false,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // 编写视图
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.brown,
                width: 350,
                height: 100,
                child: Text(debugLable ?? "Unknown"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "发本地推送",
                    onPressed: () {
                      // 三秒后出发本地推送
                      var fireDate = DateTime.fromMillisecondsSinceEpoch(
                        DateTime.now().millisecondsSinceEpoch + 3000,
                      );
                      var localNotification = LocalNotification(
                        id: 234,
                        title: 'fadsfa',
                        buildId: 1,
                        content: 'fdas',
                        fireTime: fireDate,
                        subtitle: 'fasf',
                        badge: 5,
                        extra: {"fa": "0"},
                      );
                      jpush.sendLocalNotification(localNotification).then((
                        res,
                      ) {
                        setState(() {
                          debugLable = res;
                        });
                      });
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "getLaunchAppNotification",
                    onPressed: () {
                      jpush
                          .getLaunchAppNotification()
                          .then((map) {
                            print("flutter getLaunchAppNotification:$map");
                            setState(() {
                              debugLable =
                                  "getLaunchAppNotification success: $map";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable =
                                  "getLaunchAppNotification error: $error";
                            });
                          });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "setTags",
                    onPressed: () {
                      jpush
                          .setTags(["lala", "haha"])
                          .then((map) {
                            var tags = map['tags'];
                            setState(() {
                              debugLable = "set tags success: $map $tags";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "set tags error: $error";
                            });
                          });
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "addTags",
                    onPressed: () {
                      jpush
                          .addTags(["lala", "haha"])
                          .then((map) {
                            var tags = map['tags'];
                            setState(() {
                              debugLable = "addTags success: $map $tags";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "addTags error: $error";
                            });
                          });
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "deleteTags",
                    onPressed: () {
                      jpush
                          .deleteTags(["lala", "haha"])
                          .then((map) {
                            var tags = map['tags'];
                            setState(() {
                              debugLable = "deleteTags success: $map $tags";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "deleteTags error: $error";
                            });
                          });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "getAllTags",
                    onPressed: () {
                      if (Platform.isIOS || Platform.isAndroid) {
                        jpush
                            .getAllTags()
                            .then((map) {
                              setState(() {
                                debugLable = "getAllTags success: $map";
                              });
                            })
                            .catchError((error) {
                              setState(() {
                                debugLable = "getAllTags error: $error";
                              });
                            });
                      } else {
                        jpush
                            .getTags(1)
                            .then((map) {
                              setState(() {
                                debugLable = "getTags success: $map";
                              });
                            })
                            .catchError((error) {
                              setState(() {
                                debugLable = "getTags error: $error";
                              });
                            });
                      }
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "cleanTags",
                    onPressed: () {
                      jpush
                          .cleanTags()
                          .then((map) {
                            var tags = map['tags'];
                            setState(() {
                              debugLable = "cleanTags success: $map $tags";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "cleanTags error: $error";
                            });
                          });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "setAlias",
                    onPressed: () {
                      jpush
                          .setAlias("thealias11")
                          .then((map) {
                            setState(() {
                              debugLable = "setAlias success: $map";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "setAlias error: $error";
                            });
                          });
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "deleteAlias",
                    onPressed: () {
                      jpush
                          .deleteAlias()
                          .then((map) {
                            setState(() {
                              debugLable = "deleteAlias success: $map";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "deleteAlias error: $error";
                            });
                          });
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "getAlias",
                    onPressed: () {
                      jpush
                          .getAlias()
                          .then((map) {
                            setState(() {
                              debugLable = "getAlias success: $map";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "getAlias error: $error";
                            });
                          });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "stopPush",
                    onPressed: () {
                      jpush.stopPush();
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "resumePush",
                    onPressed: () {
                      jpush.resumePush();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "clearAllNotifications",
                    onPressed: () {
                      jpush.clearAllNotifications();
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "setBadge",
                    onPressed: () {
                      jpush
                          .setBadge(66)
                          .then((map) {
                            setState(() {
                              debugLable = "setBadge success: $map";
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              debugLable = "setBadge error: $error";
                            });
                          });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "通知授权是否打开",
                    onPressed: () {
                      jpush
                          .isNotificationEnabled()
                          .then((bool value) {
                            setState(() {
                              debugLable = "通知授权是否打开: $value";
                            });
                          })
                          .catchError((onError) {
                            setState(() {
                              debugLable = "通知授权是否打开: ${onError.toString()}";
                            });
                          });
                    },
                  ),
                  Text(" "),
                  CustomButton(
                    title: "打开系统设置",
                    onPressed: () {
                      jpush.openSettingsForNotification();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" "),
                  CustomButton(
                    title: "getRegistrationID",
                    onPressed: () {
                      jpush
                          .getRegistrationID()
                          .then((rid) {
                            setState(() {
                              debugLable = "getRegistrationID: $rid";
                            });
                          })
                          .catchError((onError) {
                            setState(() {
                              debugLable =
                                  "getRegistrationID: ${onError.toString()}";
                            });
                          });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 封装控件
class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;

  const CustomButton({
    super.key,
    @required this.onPressed,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
        overlayColor: WidgetStateProperty.all(Color(0xff888888)),
        backgroundColor: WidgetStateProperty.all(Color(0xff585858)),
        padding: WidgetStateProperty.all(EdgeInsets.fromLTRB(10, 5, 10, 5)),
      ),
      child: Text("$title"),
    );
  }
}
