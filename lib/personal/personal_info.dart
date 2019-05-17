import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../common/style/Style.dart' show ICons;
import '../components/UserIconWidget.dart';
import './QR_code.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    Widget buildRow(child, title, isEnd, onPressed) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: !isEnd
                  ? BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xffd9d9d9), width: .3)))
                  : null,
              child: RawMaterialButton(
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 15.0, right: 5.0, top: 15.0),
                            child: child,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 15.0, right: 10.0, top: 15.0),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(right: 0.0),
        width: 55.0,
        height: 55.0,
        image: 'images/default_nor_avatar.png',
        isNetwork: false,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return new Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildRow(userImage, '头像', false, () {
                // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
              }),
              buildRow(
                  Text(
                    '岳帅',
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
                  '用户名',
                  false, () {
                // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
              }),
              buildRow(
                  Text(
                    'GL24324242',
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
                  '戈友ID',
                  false, () {
                // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
              }),
              buildRow(
                  Icon(
                    ICons.QR,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  '二维码名片',
                  false, () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (c) {
                      return new QRCode();
                    },
                  ),
                );
              }),
              buildRow(Text(''), '更多', true, () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return new CupertinoAlertDialog(
                      title: new Text("提示"),
                      content: new Text("该功能暂未开放，尽请期待！"),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop("点击了确定");
                          },
                          child: new Text("确认"),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop("点击了取消");
                          },
                          child: new Text("取消"),
                        ),
                      ],
                    );
                  });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
