import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/index.dart';
import 'global.dart';

void main() async {
  // 先执行依赖注入 初始化全局服务，再执行runApp
  await Global.init();

  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // 样式
      light: AppTheme.light, // 亮色主题
      dark: AppTheme.dark, // 暗色主题
      initial: ConfigService.to.themeMode, // 初始主题
      debugShowFloatingThemeButton: kDebugMode, // 显示主题按钮, 开发阶段打开, 生产阶段关闭
      builder: (theme, darkTheme) => GetMaterialApp(
        title: 'Woo 2025',
        // 主题
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: false,
        // ),
        theme: theme,
        darkTheme: darkTheme,

        // 路由
        initialRoute: RouteNames.stylesStylesIndex,
        getPages: RoutePages.list,
        navigatorObservers: [RoutePages.observer],

        // 国际化
        translations: Translation(), // 词典
        localizationsDelegates: Translation.localizationsDelegates, // 代理
        supportedLocales: Translation.supportedLocales, // 支持的语言种类
        locale: ConfigService.to.locale, // 当前语言种类
        fallbackLocale: Translation.fallbackLocale, // 默认语言种类
        // 设备预览
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,

        // 调试标志
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
