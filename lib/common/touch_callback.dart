import 'package:flutter/material.dart';

class TouchCallback extends StatefulWidget {
  // 子组件
  final Widget child;
  // 会掉函数
  final VoidCallback onPressed;
  final bool isfeed;
  // 设置背景色
  final Color background;

  TouchCallback({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.isfeed: true,
    this.background:const Color(0xffd8d8d8)
  }):super(key: key);
  
  @override
  _TouchCallbackState createState() => _TouchCallbackState();
}

class _TouchCallbackState extends State<TouchCallback> {
  Color color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    //返回GestureDetector对象
    return GestureDetector(
      //使用Container容器包裹
      child: Container(
        color: color,
        child: widget.child,
      ),
      onTap: widget.onPressed,
      onPanDown: (d){
        if(widget.isfeed == false) return;
        setState(() {
          color = widget.background;
        });
      },
      onPanCancel: (){
        setState(() {
          color = Colors.transparent;
        });
      },
    );
  }
}