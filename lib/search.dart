import 'package:flutter/material.dart';
import './common/touch_callback.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //定义焦点节点
  FocusNode focusNode = new FocusNode();

   //请求获取焦点
  _requestFocus() {
    FocusScope.of(context).requestFocus(focusNode);
    return focusNode;
  }

  //返回一个文本组件
  _getText(String text) {
    return TouchCallback(
      isfeed: false,
      onPressed: () {},
      child: Text(
        text,
        //添加文本样式
        style: TextStyle(fontSize: 14.0, color: Color(0xff1aad19)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 顶部留一定距离
        margin: const EdgeInsets.only(top: 25.0),
        // 整体垂直布局
        child: Column(
          // 水平方向居中
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //顶部导航栏 包括返回按钮 搜索框及麦克风按钮
            Stack(
              children: <Widget>[
                //使用触摸回调组件
                TouchCallback(
                  isfeed: false,
                  onPressed: () {
                    //使用导航器返回上一个页面
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45.0,
                    margin: const EdgeInsets.only(left: 12.0, right: 10.0),
                    //添加返回按钮
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                  ),
                ),
                //搜索框容器
                Container(
                  alignment: Alignment.centerLeft,
                  height: 45.0,
                  margin: const EdgeInsets.only(left: 50.0, right: 10.0),
                  //搜索框底部边框
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Color(0xff393a3f))
                    )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        //输入框
                        child: TextField(
                          // 请求获得焦点
                          // focusNode: FocusNode(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0
                          ),
                          onChanged: (String text) {
                            print("onChanged-search"+text);
                          },
                          decoration:InputDecoration(
                            hintText: '搜索戈友',
                            border: InputBorder.none
                          )
                        ),
                      ),
                      //添加麦克风图标
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.mic,
                          color:Colors.black
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: FlatButton(
                onPressed: (){

                },
                color:Color(0xffffd900),
                child: Text(
                  '搜索戈友',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white
                  ),
                  // color:Colors.white
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}