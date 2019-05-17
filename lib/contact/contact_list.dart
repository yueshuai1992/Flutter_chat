import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';
import 'contact_model.dart';
import '../common/httputil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ContactList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ContactListState();
  }
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    super.initState();
    _getContactsContent();
  }

  List<ContactInfo> _contacts = List();

  int _suspensionHeight = 40;
  int _itemHeight = 60;

  _getContactsContent() async {
    var url = HttpUtils.getUrl(article: HttpUtils.Contacts);
    HttpController.getData(url, (data) {
      if (data["errno"] == 0) {
        List list = data["data"]["contacts"];
        list.forEach((value) {
          _contacts
              .add(ContactInfo(name: value['name'], avatar: value['avatar']));
        });
        _handleList(_contacts);
      } else {
        Fluttertoast.showToast(
            msg: data["errmsg"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      setState(() {});
    });
  }

  void _handleList(List<ContactInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(list);
  }

  Widget _buildHeader() {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    ClipOval(
                        child: Image.asset(
                      "images/icon_addfriend.png",
                      width: 42.0,
                    )),
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          '发现人脉',
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xff191919)),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    ClipOval(
                        child: Image.asset(
                      "images/icon_groupchat.png",
                      width: 42.0,
                    )),
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          '寻找戈友',
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xff191919)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: _suspensionHeight.toDouble(),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            '$susTag',
            textScaleFactor: 1.2,
          ),
          Expanded(
              child: Divider(
            height: .0,
            indent: 10.0,
          ))
        ],
      ),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Offstage(
              offstage: model.isShowSuspension != true,
              child: _buildSusWidget(susTag),
            ),
            SizedBox(
              height: _itemHeight.toDouble(),
              child: ListTile(
                leading: (model.avatar.length > 0)
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(30.0)),
                        child: Image.network(
                          model.avatar.toString(),
                          width: 42.0,
                          height: 42.0,
                          fit: BoxFit.contain,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Color(0xffffd900),
                        child: Text(
                          model.name[0],
                          style: TextStyle(color: Colors.white),
                        )),
                title: Text(model.name),
                onTap: () {
                  showDialog(
                      context: context,
                      child: new AlertDialog(
                        title: new Text("${model.name}",textAlign: TextAlign.center),
                        content: Text("你好${model.name}，你在哪里？", textAlign: TextAlign.center),
                        actions: <Widget>[
                          new FlatButton(
                            textTheme: ButtonTextTheme.accent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: new Text('确定')
                          )
                        ],
                      ));
                  print("OnItemClick: ${model.name}");
                  // Navigator.pop(context, model);
                },
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: _contacts,
      itemBuilder: (context, model) {
        return _buildListItem(model);
      },
      isUseRealIndex: true,
      itemHeight: _itemHeight,
      suspensionHeight: _suspensionHeight,
      header: AzListViewHeader(
          height: 140,
          builder: (context) {
            return _buildHeader();
          }),
      indexBarBuilder: (BuildContext context, List<String> tags,
          IndexBarTouchCallback onTouch) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey[300], width: .5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: IndexBar(
              data: tags,
              itemHeight: 20,
              onTouch: (details) {
                onTouch(details);
              },
            ),
          ),
        );
      },
      indexHintBuilder: (context, hint) {
        return Container(
          alignment: Alignment.center,
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Color(0xffffd900).withAlpha(200),
            shape: BoxShape.circle,
          ),
          child:
              Text(hint, style: TextStyle(color: Colors.white, fontSize: 30.0)),
        );
      },
    );
  }
}
