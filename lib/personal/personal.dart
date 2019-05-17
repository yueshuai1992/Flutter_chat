import 'package:flutter/material.dart';
import '../components/UserIconWidget.dart';
import '../common/style/Style.dart' show ICons;
import './personal_info.dart';

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(top: 5.0, right: 18.0, left: 15.0),
        width: 55.0,
        height: 55.0,
        image: 'images/default_nor_avatar.png',
        isNetwork: false,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    Widget buildRow(icon, title, isEnd) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new UserIconWidget(
              padding: const EdgeInsets.only(top: 0.0, right: 14.0, left: 14.0),
              width: 22.0,
              height: 22.0,
              image: icon,
              isNetwork: false,
              onPressed: () {
                // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
              }),
          Expanded(
            child: Container(
              decoration: !isEnd
                  ? BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xffd9d9d9), width: .3)))
                  : null,
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  Container(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15.0, right: 10.0),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              height: 100.0,
              child:
               RawMaterialButton(
                onPressed: () {
                  Navigator.push(context,
                    new MaterialPageRoute(
                      builder: (c) {
                        return new PersonalInfoPage();
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    userImage,
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '岳帅',
                                style: TextStyle(
                                    fontSize: 22.5, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 2.0,
                              ),
                              Text(
                                '戈友ID：GL24324242',
                                maxLines: 1,
                                style: TextStyle(color: Colors.grey, fontSize: 13.0),
                              )
                            ],
                          ),
                        )),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 25.0, bottom: 15.0, right: 10.0),
                          child: Icon(
                            ICons.QR,
                            color: Colors.grey,
                            size: 15.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 25.0, bottom: 15.0, right: 10.0),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  color: Color(0xffEDEDED),
                  height: 10.0,
                ),
                buildRow('images/me_pay.png', '支付', true),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    color: Color(0xffEDEDED),
                    height: 10.0,
                  ),
                  buildRow('images/me_college.png', '收藏', false),
                  buildRow('images/me_gallary.png', '相册', false),
                  buildRow('images/me_wallet.png', '卡包', false),
                  buildRow('images/me_face.png', '表情', true),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  color: Color(0xffEDEDED),
                  height: 10.0,
                ),
                buildRow('images/me_setting.png', '设置', true),
              ],
            ),
          ],
        )
      ],
    );
  }
}
