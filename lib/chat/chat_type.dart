import 'package:flutter/material.dart';
/// ChatItem: 消息体
/// id: 消息Id
/// msg: 消息内容
/// type: 表示类型 1.为文字 2.为图片 3.为语音 4. 表情
/// self: 1为自己 0为他人

class ChatItem {
  int id;
  var msg;
  int type;
  int self;
  AnimationController animationController;

  ChatItem(this.id, this.msg, this.type, this.self, this.animationController);

  getMsg() {
    return msg;
  }
}