import 'package:flutter/material.dart';
class ChatBottomMenu {

    final VoidCallback takePhoto;
    final VoidCallback openGallery;
    final VoidCallback getPosition;
    final VoidCallback showEmojis;
    ChatBottomMenu({this.takePhoto, this.openGallery, this.getPosition, this.showEmojis});
    
    getMenus(){
      /*底部菜单*/
      List<Menu> menus = [
        Menu('照片', Icons.photo_size_select_actual, openGallery),
        Menu('拍摄', Icons.photo_camera, takePhoto),
        Menu('位置', Icons.room, getPosition),
        Menu('表情', Icons.sentiment_satisfied, showEmojis),
        // Menu('照片', Icons.photo_size_select_actual, () {}),
        // Menu('拍摄', Icons.photo_camera, () {}),
      ];

      List<Widget> widget = [];

      menus.forEach((item) {
        widget.add(RawMaterialButton(
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.white,
                    child: Icon(item.icon, size: 28.0),
                  )),
              Text(
                item.name,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    height: 1.2),
              )
            ],
          ),
          onPressed: item.onPressed,
        ));
      });

      return widget;
    }  
}

// 底部菜单
class Menu {
  String name;
  IconData icon;
  final VoidCallback onPressed;
  Menu(this.name, this.icon, this.onPressed);
}