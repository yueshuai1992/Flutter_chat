import 'package:flutter/material.dart';
import './message_data.dart';
import './message_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh(
        key: _easyRefreshKey,
        refreshHeader: PhoenixHeader(
          key: _headerKey,
        ),
        refreshFooter: PhoenixFooter(
          key: _footerKey,
        ),
        child: ListView.builder(
          //传入数据长度
          itemCount: messageData.length,
          //构造列表项
          itemBuilder: (BuildContext context, int index) {
            //传入messageData返回列表项
            return new MessageItem(messageData[index]);
          },
        ),
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1), () {
            if (!mounted) return;
            // setState(() {
            //   str.clear();
            //   str.addAll(addStr);
            // });
          });
        },
        loadMore: () async {
          await new Future.delayed(const Duration(seconds: 1), () {
            // if (str.length < 20) {
            //   setState(() {
            //     str.addAll(addStr);
            //   });
            // }
          });
        },
      ),
    );
  }
}