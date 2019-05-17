import 'package:flutter/material.dart';

class ChatEmoji extends StatelessWidget {
  final emojis;
  final _sendEmojis;
  ChatEmoji(this.emojis, this._sendEmojis);
  List<Widget> buildGridTileList() {
    List<Widget> widgetList = new List();
    emojis.forEach((k, v) {
      widgetList.add(mainMessage(k, v));
    });
    return widgetList;
  }

  Widget mainMessage(k, v) {
    return GestureDetector(
      onTap: () {
        _sendEmojis(k);
      },
      child: Text(
        v,
        style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 20.0,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: GridView.count(
          //滚动方向
          scrollDirection: Axis.horizontal,
          primary: false,
          padding: EdgeInsets.only(left: 12.0, top: 5.0, right: 5.0, bottom: 5.0),
          mainAxisSpacing: 10.0,
          crossAxisCount: 4,
          children: buildGridTileList()),
    );
  }
}
