import 'package:flutter/material.dart';

class Found {
  const Found(
      {@required this.avatar, @required this.name, this.isNetwork = false, this.isWhite = false, this.id})
      : assert(avatar != null),
        assert(name != null);
  final String avatar;
  final String name;
  final bool isNetwork;
  final bool isWhite;
  final String id;
}

List<Found> mockContact = [
  const Found(avatar: 'images/find_friend_circle.png', name: '朋友圈', id: 'friend'),
  const Found(avatar: 'images/find_game.png', name: '戈友活动中心', id: 'active'),
  const Found(avatar: 'images/find_shop.png', name: '戈友商城', isWhite: true, id: 'shop'),
  const Found(avatar: 'images/find_scan.png', name: '扫一扫', id: 'scan'),
  const Found(avatar: 'images/find_shake.png', name: '摇一摇', isWhite: true, id: 'shake'),
  const Found(avatar: 'images/find_sou.png', name: '搜一搜', id: 'sou'),
  const Found(avatar: 'images/find_show.png', name: '看一看', isWhite: true, id: 'show'),
  const Found(avatar: 'images/find_nearby.png', name: '附近的人',  id: 'nearby'),
  const Found(avatar: 'images/find_bottle.png', name: '漂流瓶', isWhite: true, id: 'bottle'),
  const Found(avatar: 'images/find_xcx.png', name: '小程序', isWhite: true, id: 'xcx')
];



