import 'package:flutter/material.dart';

class ChatVoice extends StatelessWidget {
  final chatVoiceOff;
  final chatNoticeText;
  ChatVoice(this.chatVoiceOff, this.chatNoticeText);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
        child: Center(
          child: Container(
            width: 140.0,
            height: 140.0,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Column(
              children: <Widget>[
                Icon(
                  chatVoiceOff?Icons.mic_off:Icons.mic,
                  color: Colors.white,
                  size: 90.0,
                ),
                Text(
                  this.chatNoticeText,
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 13.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ));
  }
}
