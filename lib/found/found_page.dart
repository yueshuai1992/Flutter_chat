import 'package:flutter/material.dart';
import './found.dart' show Found, mockContact;
import 'package:fluwx/fluwx.dart' as fluwx;
import '../common/web_view._widget.dart';

class FoundPage extends StatefulWidget {
  @override
  _FoundPageState createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fluwx.register(
        appId: "wxd930ea5d5a258f4f",
        doOnAndroid: true,
        doOnIOS: true,
        enableMTA: false);
    var result = fluwx.isWeChatInstalled();
    print("is installed $result");
    fluwx.responseFromLaunchMiniProgram.listen((data) {
      print(data);
    });
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: mockContact.length,
          itemBuilder: (BuildContext context, int index) {
            return _FoundItem(
              find: mockContact[index],
            );
          }),
    );
  }
}

class _FoundItem extends StatelessWidget {
  final Found find;

  _FoundItem({Key key, this.find})
      : assert(find != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget itemRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(5.0)),
            child: Image.asset(
              find.avatar,
              width: 30.0,
              height: 30.0,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffd9d9d9), width: .3))),
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      find.name,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(top: 16.0, right: 10.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15.0, right: 10.0),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      // size: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    var listEventFun = {
      'friend': (){
        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return WebViewWidget(url:'http://agrowingchina.com.cn/huodong', title:'戈友活动中心');
        }));
      },
      'scan': (){
        print('scan');
      },
      'shake': (){
        print('shake');
      },
      'show': (){
        print('show');
      },
      'sou': (){
        print('sou');
      },
      'nearby': (){
        print('nearby');
      },
      'bottle': (){
        print('bottle');
      },
      'shop': (){
        fluwx.launchMiniProgram(username: "gh_5ed0dd236e45").then((data) {
          print(data);
        });
      },
      'active': (){
        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return WebViewWidget(url:'http://agrowingchina.com.cn/huodong', title:'戈友活动中心');
        }));
      },
      'xcx': (){
        print('xcx');
      }
    };
    
    return Container(
        height: find.isWhite ? 76 : 55,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            listEventFun[find.id]();
          },
          child: find.isWhite
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      color: Color(0xffEDEDED),
                      height: 20.0,
                    ),
                    itemRow,
                  ],
                )
              : itemRow,
        ));
  }
}
