import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:dio/dio.dart';
import '../components/UserIconWidget.dart';
import './chat_type.dart';
import './chat_me_message.dart';
import './chat_other_message.dart';
import './chat_bottom_menu.dart';
import './chat_picture_zoom.dart';
import './chat_voice.dart';
import './emojis.dart';
import './chat_emoji.dart';

class HomeChatPage extends StatefulWidget {
  final messageData;

  HomeChatPage({Key key, this.messageData}) : super(key: key);

  @override
  _HomeChatPageState createState() => _HomeChatPageState(messageData);
}

class _HomeChatPageState extends State<HomeChatPage>
    with TickerProviderStateMixin {
  // socket连接
  IOWebSocketChannel channel;

  final messageData; // 消息列表传过来数据
  int id; // 最后一条消息的ID
  ScrollController _scrollController = new ScrollController(); // 设置滚动位置
  bool menuShow = false; // 定义底部菜单展示
  final controller = TextEditingController(); // 输入框
  bool voiceTextInputChange = false; // 设置输入的改变
  bool chatVoiceShow = false; // 设置输入弹出的黑色麦克
  bool chatVoiceOff = false; // 设置麦克风为关闭，也就是语音取消发送
  int onVerticalDragStartY = 0; // 底部按住说话位置
  int onVerticalDragUpdateY = 0; // 底部按住说话位置
  String chatNoticeText = "手指上滑 取消发送"; // 提示的文案
  // 初始化语音聊天变量
  String voidPath;
  bool _isRecording = false;
  bool _isPlaying = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';

  //初始化表情
  Map mapEmojis = Emojis().mapEmojis;
  bool emojisShow = false; // 定义底部表情展示

  Map picZoom = {
    'show': false,
    'picIndex': 0, // 图片的索引
    'pictures': []
  };

  List<ChatItem> chatMessagesLists;

  /// ChatItem: 消息体
  /// id: 消息Id
  /// msg: 消息内容
  /// type: 表示类型 1.为文字 2.为图片 3.为语音 4. 表情
  /// self: 1为自己 0为他人
  List<ChatItem> items = new List();

  // 展示图片轮播
  picZoomShow(chatItem) {
    int id = chatItem.id;
    List pics = picZoom['pictures'];
    int index;
    for (int i = 0; i < pics.length; i++) {
      if (pics[i]['id'] == id) {
        index = i;
      }
    }
    setState(() {
      picZoom['picIndex'] = index;
      picZoom['show'] = true;
    });
  }

  // 初始化数据
  void initData() async {
    channel.stream.listen((message) {
      Map messages = json.decode(message);
      List datas = messages["data"];
      datas.forEach((item) {
        var message = new ChatItem(
            item['id'],
            item['message'],
            item['type'],
            item['self'],
            new AnimationController(
                vsync: this, duration: Duration(milliseconds: 0)));
        //状态变更，向聊天记录中插入新记录
        setState(() {
          if (item['type'] == 2) {
            picZoom['pictures'].add({'id': item['id'], 'url': item['message']});
          }
          print(picZoom);
          items.add(message);
        });
        message.animationController.forward();
        scrollBottom();
      });
      id = datas[datas.length - 1]['id'];
    });
  }

  _HomeChatPageState(this.messageData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = IOWebSocketChannel.connect("ws://192.168.1.170:7000");
    initData();

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
  }

  /*滚动到底部*/
  void scrollBottom() {
    // 滚动到底部
    Timer _time = Timer(Duration(milliseconds: 500), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
      );
    });
  }

  //定义发送文本事件的处理函数
  void _sendMessage(val) {
    channel.sink.add(json.encode(val));
  }

  void _handleSubmitted(text, [int type = 1]) async {
    if(text == null || text == '') {
      return ;
    }
    if (text is File || type == 3) {
      List nameList;
      File file;
      var _text = text;
      if (type == 3) {
        nameList = text['url'].split('/');
        file = new File(text['url']);
      } else {
        nameList = text.path.split('/');
        file = text;
      }

      String name =
          '${messageData.userId}_${(id + 1).toString()}_${nameList[nameList.length - 1]}';
      Response response = await uploadFile(type, name, file);
      Map responseMap = json.decode(response.toString());
      if (responseMap['result'] == 1) {
        if(type == 3) {
          text = {
            'url': 'http://192.168.1.170:5000/' + responseMap['fileName'],
            'length': _text['length']
          };
        } else {
          text = 'http://192.168.1.170:5000/' + responseMap['fileName'];
        }
      }
    } else {
      if (text.length > 0) {
        controller.text = text;
      }
    }

    if (controller.text.length > 0 || text.length > 0) {
      if (type == 1) {
        controller.clear();
      } //清空输入框
      ChatItem message = new ChatItem(
          Random().nextInt(100),
          text,
          type,
          1,
          new AnimationController(
              vsync: this, duration: Duration(milliseconds: 100)));
      print(items);
      message.animationController.forward();
      _sendMessage({'message': text, 'type': type, 'self': 1, 'id': 11});
      scrollBottom();
    }
  }

  // 上传文件
  uploadFile(type, name, file) async {
    FormData formData = new FormData.from({
      "total": "1",
      "index": 0,
      'fileMd5Value': 'f8e9a28cfff602beefc915775ae29a27',
      "data": new UploadFileInfo(file, name),
    });
    Dio dio = new Dio();
    Response response =
        await dio.post("http://192.168.1.170:5000/upload", data: formData);
    return response;
  }

  /*语音聊天*/
  // 开始录音
  void startRecorder() async {
    try {
      voidPath = await flutterSound.startRecorder(null);
      print('startRecorder: $voidPath');

      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

        print('startRecorder: ${this._recorderTxt}');
        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      });
      _dbPeakSubscription =
          flutterSound.onRecorderDbPeakChanged.listen((value) {
        print("got update -> $value");
      });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  // 停止录音
  void stopRecorder() async {
    try {
      String result = await flutterSound.stopRecorder();
      int length = int.parse(_recorderTxt.split(':')[1]);
      if (length < 1) {
        Fluttertoast.showToast(
            msg: '时间太短 重新发送',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Map message = {'url': voidPath, 'length': length};
        _handleSubmitted(message, 3);
      }

      print('stopRecorder: $result');

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  void startPlayer(url) async {
    String path = await flutterSound.startPlayer(url);
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          this.setState(() {
            this._isPlaying = true;
            this._playerTxt = txt.substring(0, 8);
          });
        }
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void stopPlayer() async {
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        this._isPlaying = false;
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
    print('pausePlayer: $result');
  }

  void resumePlayer() async {
    String result = await flutterSound.resumePlayer();
    print('resumePlayer: $result');
  }

  void seekToPlayer(int milliSecs) async {
    String result = await flutterSound.seekToPlayer(milliSecs);
    print('seekToPlayer: $result');
  }

  // 设置展示表情列表
  void _showEmojis() {
    scrollBottom();
    setState(() {
      menuShow = false;
      emojisShow = true;
    });
  }

  void _sendEmojis(key) {
    _handleSubmitted(key, 4);
  }

  @override
  void dispose() {
    for (ChatItem message in items)
      message.animationController.dispose(); //  释放动效
    channel.sink.close(status.goingAway); // 释放websocket
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*拍照*/
    _takePhoto() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _handleSubmitted(image, 2);
      });
    }

    /*相册*/
    _openGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _handleSubmitted(image, 2);
      });
    }

    /*获取位置功能*/
    _getPosition() {
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
                )
              ],
            );
          });
    }

    // 底部点击输入的菜单类型 （语音或文字）
    Widget inputType() {
      // 语音
      Widget voice = GestureDetector(
        onLongPress: () {
          setState(() {
            chatVoiceShow = true;
          });
          if (!this._isRecording) {
            return this.startRecorder();
          }
          this.stopRecorder();
        },
        onLongPressUp: () {
          this.stopRecorder();
          setState(() {
            chatVoiceShow = false;
          });
        },
        onVerticalDragStart: (e) {
          onVerticalDragStartY = e.globalPosition.dy.toInt();
        },
        onVerticalDragUpdate: (e) {
          onVerticalDragUpdateY = e.globalPosition.dy.toInt();
          if (onVerticalDragStartY > (onVerticalDragUpdateY + 5)) {
            setState(() {
              chatVoiceOff = true;
              this.stopRecorder();
            });
          } else {
            setState(() {
              this.stopRecorder();
              chatVoiceOff = false;
            });
          }
        },
        onVerticalDragEnd: (details) {
          setState(() {
            chatVoiceShow = false;
            chatVoiceOff = false;
          });
          // print(details.primaryVelocity);
        },
        child: Container(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              color: Colors.white),
          child: Text(
            '按住 说话',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        ),
      );
      // 文字
      Widget text = Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: Colors.white),
        child: TextField(
          controller: controller,
          decoration: InputDecoration.collapsed(hintText: null),
          autocorrect: true,
          //是否自动更正
          autofocus: false,
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.green,
          onChanged: (text) {
            //内容改变的回调
            print('change=================== $text');
          },
          onTap: () {
            scrollBottom();
            setState(() {
              menuShow = false;
              emojisShow = false;
            });
          },
          onSubmitted: _handleSubmitted,
          enabled: true, //是否禁用
        ),
      );
      return Expanded(
        child: voiceTextInputChange ? voice : text,
      );
    }

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(messageData.title),
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.8)),
          body: new Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                    "http://pic.sc.chinaz.com/files/pic/pic9/201809/zzpic14004.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatContentView(
                      chatItem: items[index],
                      messageData: messageData,
                      picZoomShow: picZoomShow,
                      startVoice: startPlayer,
                    );
                  },
                  itemCount: items.length,
                )),
                Divider(
                  height: 1.0,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 1.0, bottom: 1.0, right: 3.0, left: 3.0),
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35.0,
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                            //语音按钮
                            icon: new Icon(voiceTextInputChange
                                ? Icons.keyboard
                                : Icons.keyboard_voice), //发送按钮图标
                            onPressed: () {
                              setState(() {
                                voiceTextInputChange = !voiceTextInputChange;
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              });
                            }),
                      ),
                      inputType(),
                      Container(
                        width: 30.0,
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                            //发送按钮
                            icon: new Icon(Icons.send), //发送按钮图标
                            onPressed: () {
                              _handleSubmitted(controller.text, 1);
                            }), //触发发送消息事件执行的函数_handleSubmitted
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        width: 25.0,
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // Timer _time =
                                //     Timer(Duration(milliseconds: 100), () {
                                  menuShow = !menuShow;
                                  emojisShow = false;
                                  scrollBottom();
                                // });
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: !menuShow,
                  child: Container(
                      height: 100,
                      padding: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 0.5, color: Color(0xFFd9d9d9))),
                          color: Color.fromRGBO(255, 255, 255, 0.9)),
                      child: GridView.count(
                          //滚动方向
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          padding: const EdgeInsets.all(5.0),
                          mainAxisSpacing: 10.0,
                          crossAxisCount: 1,
                          children: ChatBottomMenu(
                                  takePhoto: _takePhoto,
                                  openGallery: _openGallery,
                                  getPosition: _getPosition,
                                  showEmojis: _showEmojis)
                              .getMenus())),
                ),
                Offstage(
                    offstage: !emojisShow,
                    child: Container(
                        height: 180.0,
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                        child: ChatEmoji(mapEmojis, _sendEmojis)))
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                picZoom['show'] = false;
              });
            },
            child: (picZoom['show'] && picZoom['pictures'].length > 0)
                ? ChatPictuZoom(picZoom)
                : Container(),
          ),
        ),
        Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: chatVoiceShow
                ? ChatVoice(chatVoiceOff, chatNoticeText)
                : Container())
      ],
    );
  }
}

class ChatContentView extends StatelessWidget {
  final ChatItem chatItem;
  final messageData;
  final picZoomShow;
  final startVoice;

  ChatContentView(
      {Key key,
      this.chatItem,
      this.messageData,
      this.picZoomShow,
      this.startVoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: EdgeInsets.only(
            top: 0.0,
            right: (chatItem.self == 1 ? 0.0 : 5.0),
            left: (chatItem.self == 1 ? 5.0 : 0.0)),
        width: 35.0,
        height: 35.0,
        image: chatItem.self == 1
            ? 'images/default_nor_avatar.png'
            : messageData.avatar,
        // isNetwork: (chatItem.type == 1 && messageData.isNetwork),
        isNetwork: chatItem.self == 0,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: this.chatItem.animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: chatItem.self == 1
            ? ChatMeMessage(
                chatItem: chatItem,
                userImage: userImage,
                picZoomShow: picZoomShow,
                startPlayer: startVoice)
            : ChatOtherMessage(
                chatItem: chatItem,
                userImage: userImage,
                picZoomShow: picZoomShow,
                startPlayer: startVoice));
  }
}
