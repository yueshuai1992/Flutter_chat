import 'package:flutter/material.dart';
import './emojis.dart';

class ChatMeMessage extends StatelessWidget {
  final chatItem;
  final userImage;
  final picZoomShow;
  final startPlayer;
  ChatMeMessage({this.chatItem, this.userImage, this.picZoomShow, this.startPlayer});

  Map mapEmojis = Emojis().mapEmojis;

  @override
  Widget build(BuildContext context) {
    // 文字
    Widget buildText() {
      return Column(
        // Column被Expanded包裹起来，使其内部文本可自动换行
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage('static/images/chat_bg.png'), fit: BoxFit.fill),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              color: Color(0xFF9EEA6A),
            ),
            child: Text(
              chatItem.msg,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          )
        ],
      );
    }

    // 图片
    Widget buildImage() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            RawMaterialButton(
                constraints:
                    const BoxConstraints(maxWidth: 180.0, maxHeight: 180.0),
                onPressed: () {
                  picZoomShow(chatItem);
                },
                child: ClipRRect(
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(5.0)),
                  child: Image(
                      image: (chatItem.msg is String)
                          ? NetworkImage(chatItem.msg)
                          : FileImage(chatItem.msg)),
                ))
          ]);
    }

    // 声音
    Widget buildVoice() {
      return GestureDetector(
        onTap: () {
          startPlayer(chatItem.msg['url']);
        },
        child: Column(
          // Column被Expanded包裹起来，使其内部文本可自动换行
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 80.0+chatItem.msg['length'],
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Color(0xFF9EEA6A),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      chatItem.msg['length'].toString() + "''",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                  Icon(Icons.graphic_eq),
                ],
              ),
            )
          ],
        )
      );
    }

    // 表情
    Widget buildEmoji() {
      return Column(
        // Column被Expanded包裹起来，使其内部文本可自动换行
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage('static/images/chat_bg.png'), fit: BoxFit.fill),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              color: Color(0xFF9EEA6A),
            ),
            child: Text(
              mapEmojis[chatItem.msg],
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          )
        ],
      );
    }

    //判断类型返回应用的widget
    Widget justWidget() {
      Widget widget;
      if (chatItem.type == 1) {
        widget = buildText();
      } else if (chatItem.type == 2) {
        widget = buildImage();
      } else if (chatItem.type == 3) {
        widget = buildVoice();
      } else if (chatItem.type == 4) {
        widget = buildEmoji();
      }
      return Expanded(
        child: widget,
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[justWidget(), userImage],
      ),
    );
  }
}
