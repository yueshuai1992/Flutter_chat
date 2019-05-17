import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './chat/message_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import './contact/contact_list.dart';
import './found/found_page.dart';
import './personal/personal.dart';
import './components/my_bottom_navigation_bar.dart';

import 'package:device_info/device_info.dart';
import 'dart:io';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /**
   * 获取设备信息
   */
  static final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;
    setState(() {
      _deviceData = deviceData;
    });
  }
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
    };
  }
  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  
  /**
   * 打开相机
   */
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print("barcode>>>>>$barcode");
      setState(() {
        return this.barcode = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
  /**
   * 初始化菜单
   */

  var _currentIndex = 1;
  List menuList = ['通讯录', '消息', '发现', '我的'];
  String barcode = "";

  MessagePage message;
  ContactList contactList;
  FoundPage foundPage;
  Personal personal;

  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (contactList == null) {
          contactList = new ContactList();
        }
        return contactList;
        break;
      case 1:
        if (message == null) {
          message = new MessagePage();
        }
        return message;
        break;
      case 2:
        if (foundPage == null) {
          foundPage = new FoundPage();
        }
        return foundPage;
        break;
      case 3:
        if (personal == null) {
          personal = new Personal();
        }
        return personal;
        break;
      default:
    }
  }

  //渲染某个菜单项 传入菜单标题 图片路径或图标
  _popupMenuItem(String title, {String imagePath, IconData icon}) {
    return PopupMenuItem(
        child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (title == '扫一扫') {
          return scan();
        }
      },
      child: Row(
        children: <Widget>[
          //判断是使用图片路径还是图标
          imagePath != null
              ? Image.asset(
                  imagePath,
                  width: 18.0,
                  height: 32.0,
                )
              : SizedBox(
                  width: 18.0,
                  height: 32.0,
                  child: Icon(icon, color: Colors.white),
                ),
          //显示菜单项文本内容
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(title, style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(menuList[_currentIndex]),
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                //跳转至搜索页面
                Navigator.pushNamed(context, 'search');
              },
              child: Icon(Icons.search),
            ),
            Padding(
                //左右内边距
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: (GestureDetector(
                  onTap: () {
                    //弹出菜单
                    showMenu(
                        context: context,
                        //定位在界面的右上角
                        position: RelativeRect.fromLTRB(500.0, 96.0, 10.0, 0),
                        items: <PopupMenuEntry>[
                          _popupMenuItem('添加好友',
                              imagePath: 'images/icon_menu_addfriend.png'),
                          _popupMenuItem('扫一扫', icon: Icons.crop_free),
                          _popupMenuItem('帮助与反馈', icon: Icons.email)
                        ]);
                  },
                  child: Icon(Icons.add),
                ))),
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          type: MyBottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: ((index) {
            setState(() {
              _currentIndex = index;
            });
          }),
          items: [
            new BottomNavigationBarItem(
                title: new Text(menuList[0],
                    style: TextStyle(
                        fontSize: 14.0,
                        color: _currentIndex == 0
                            ? Color(0xff000000)
                            : Color(0xff585858))),
                icon: _currentIndex == 0
                    ? Image.asset(
                        'images/address_icon_active.png',
                        width: 18.0,
                        height: 22.0,
                      )
                    : Image.asset(
                        'images/address_icon.png',
                        width: 18.0,
                        height: 22.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(menuList[1],
                    style: TextStyle(
                        fontSize: 14.0,
                        color: _currentIndex == 1
                            ? Color(0xff000000)
                            : Color(0xff585858))),
                icon: _currentIndex == 1
                    ? Image.asset(
                        'images/messages_icon_active.png',
                        width: 18.0,
                        height: 22.0,
                      )
                    : Image.asset(
                        'images/messages_icon.png',
                        width: 18.0,
                        height: 22.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(menuList[2],
                    style: TextStyle(
                        fontSize: 14.0,
                        color: _currentIndex == 2
                            ? Color(0xff000000)
                            : Color(0xff585858))),
                icon: _currentIndex == 2
                    ? Image.asset(
                        'images/find_icon_active.png',
                        width: 18.0,
                        height: 22.0,
                      )
                    : Image.asset(
                        'images/find_icon.png',
                        width: 18.0,
                        height: 22.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(menuList[3],
                    style: TextStyle(
                        fontSize: 14.0,
                        color: _currentIndex == 3
                            ? Color(0xff000000)
                            : Color(0xff585858))),
                icon: _currentIndex == 3
                    ? Image.asset(
                        'images/my_icon_active.png',
                        width: 18.0,
                        height: 22.0,
                      )
                    : Image.asset(
                        'images/my_icon.png',
                        width: 18.0,
                        height: 22.0,
                      ))
          ],
        ),
        body: currentPage()
      );
  }
}
