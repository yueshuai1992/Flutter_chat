import 'package:flutter/material.dart';
import 'app.dart';
import 'loading.dart';
import './search.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

void main(List<String> args) async {
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '通讯录',
    theme: mDefaultTheme,
    routes: <String, WidgetBuilder>{
      "app": (BuildContext context) => new App(),
      // "/friends": (_) => webViewConfig("https://www.baidu.com","微信朋友圈"),
      // "/active": (_) =>
      //     webViewConfig('http://agrowingchina.com.cn/huodong', '戈友活动中心'),
      'search': (BuildContext context) => new Search() //搜索页面路由,
    },
    home: new LoadingPage(), // 启动页
  ));
}

final ThemeData mDefaultTheme = new ThemeData(
    primaryColor: Color(0xffEDEDED),
    // scaffoldBackgroundColor: Color(0xFFebebeb),
    cardColor: Color(0xff4C4C4C));

