import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../components/UserIconWidget.dart';

class QRCode extends StatefulWidget {
  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 18.0),
        width: 62.0,
        height: 62.0,
        image: 'images/default_nor_avatar.png',
        isNetwork: false,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });

    Widget buildTop() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          userImage,
          Expanded(
              child: Container(
            height: 62.0,
            margin: EdgeInsets.only(top: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '岳帅',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff111111)),
                ),
                Container(
                  height: 2.0,
                ),
                Text(
                  '北京多米科技股份有限公司总经理',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xff585858),
                    fontSize: 14.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )),
        ],
      );
    }

    Widget buildQRCode() {
      return Container(
          margin: EdgeInsets.only(top: 13.0, bottom: 13.0),
          child: Stack(
            children: <Widget>[
              new Image.asset(
                'images/qrcode_bg.png',
                width: 304.0,
                height: 304.0,
              ),
              Positioned(
                  width: 304.0,
                  height: 304.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      QrImage(
                        data: "24242424GL",
                        size: 120,
                        onError: (ex) {
                          print("[QR] ERROR - $ex");
                        },
                      ),
                    ],
                  ))
            ],
          ));
    }

    Widget buildMain() {
      return Column(
        children: <Widget>[
          buildTop(),
          buildQRCode(),
          Text('扫描一下二维码加我为好友', style: TextStyle(
            color: Color(0xffa8a5a5),
            fontSize: 12.0,
            fontWeight: FontWeight.w500
          ),)
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('名片二维码'),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xfff6f6f6),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xfff6f6f6),
        ),
        alignment: FractionalOffset.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 30.0),
            width: 338.0,
            height: 439.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x17000000),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 5.0)
                ]),
            child: buildMain()),
      ),
    );
  }
}
