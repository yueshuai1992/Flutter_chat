import 'package:flutter/material.dart';
import './emojis.dart';

class ChatOtherMessage extends StatelessWidget {
  final chatItem;
  final userImage;
  final picZoomShow;
  final startPlayer;

  ChatOtherMessage({this.chatItem, this.userImage, this.picZoomShow, this.startPlayer});

  Map mapEmojis = Emojis().mapEmojis;

  @override
  Widget build(BuildContext context) {
    // 文字
    Widget buildText() {
      return Expanded(
        child: GestureDetector(
        onLongPress: () {
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  color: Colors.yellow),
              child: Text(
                chatItem.msg,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ));
    }

    // 图片
    Widget buildImage() {
      return RawMaterialButton(
          constraints: const BoxConstraints(maxWidth: 180.0, maxHeight: 180.0),
          onPressed: () {
            picZoomShow(chatItem);
          },
          child: ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
            child: Image(image: NetworkImage(chatItem.msg)),
          ));
    }

    // 声音
    Widget buildVoice() {
      return Expanded(
        child: GestureDetector(
        onTap: () {
          startPlayer(chatItem.msg['url']);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80.0 + chatItem.msg['length'],
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  color: Colors.yellow),
              child: Row(
                children: <Widget>[
                  Icon(Icons.graphic_eq),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      chatItem.msg['length'].toString() + "''",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ));
    }

    // 表情
    Widget buildEmoji() {
      return Expanded(
        child: GestureDetector(
        onLongPress: () {
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  color: Colors.yellow),
              child: Text(
                mapEmojis[chatItem.msg],
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ));
    }

    Widget justMessageType() {
      if(chatItem.type == 1) {
        return buildText();
      } else if(chatItem.type == 2) {
        return buildImage();
      } else if(chatItem.type == 3) {
        return buildVoice();
      } else if(chatItem.type == 4) {
        return buildEmoji();
      } else {
        return Container();
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          userImage,
          justMessageType()
        ],
      ),
    );
  }
}
