# flutter_woo_2025

Flutter [学习项目](https://ducafecat.com/course/flutter-woo-2025)


# 1.9 改包名、程序名
```
# [rename 工具](https://pub.dev/packages/rename)
flutter pub global activate rename

# 改包名
flutter pub global run rename setBundleId --value com.ducafecat.woo2025

# 改程序名
flutter pub global run rename setAppName --value woo2025

# [生成 android/ios/web 平台图标工具](https://icon.kitchen/)
```

# 3.8 生成&查看文档

```
# 配置环境变量
export FLUTTER_ROOT=~/fvm/default

# 安装 dartdoc
dart pub global activate dartdoc

# 生成文档
dart pub global run dartdoc

# 安装 http 服务
dart pub global activate dhttpd

# 执行 dhttpd
dhttpd --path doc/api

```
