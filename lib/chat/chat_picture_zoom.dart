import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:io';

class ChatPictuZoom extends StatelessWidget {
  final picZoom;
  ChatPictuZoom(this.picZoom);
  @override
  Widget build(BuildContext context) {
    final index = picZoom['picIndex'];
    final pictures = picZoom['pictures'];
    return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.9) 
        ),
        child: Center(
          child:new Swiper(
            index: index,
            itemBuilder: (context, index) {
              return new Container(
                child: new Center(
                  child: (pictures[index]['url'] is File) ? Image.file(pictures[index]['url']) : Image.network(pictures[index]['url']),
                ),
              );
            },
            itemCount: pictures.length),
        ),
      );
  }
}
