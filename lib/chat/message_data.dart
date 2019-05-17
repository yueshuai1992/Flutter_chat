// 消息类型枚举类型
enum MessageType { SYSTEM,PUBLIC,CHAT,GROUP }

class MessageData {
  // id
  String userId;
  // 头像
  String avatar;
  // 主标题
  String title;
  // 子标题
  String subTitle;
  // 消息时间
  DateTime time;
  // 消息类型
  MessageType type;

  MessageData(this.userId, this.avatar,this.subTitle,this.title,this.time,this.type);
}

// 组装数据
List<MessageData> messageData = [
    new MessageData(
      'G2440023',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403282649&di=c4f237332e6bf94546c950817699c2fd&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201504%2F11%2F20150411H0128_PHr4z.jpeg',
      '一休哥',
      '突然想到的',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440025',
       'https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=06e5d8d8a664034f0fcdc50097f81e0c/8c1001e93901213ff51058d959e736d12f2e9597.jpg',
      '多拉a梦',
      '机器猫！！！',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440024',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403360209&di=ec25c22642ec5e3858dc70a393ca0697&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20110901%2FImg318072437.jpg',
      '一休哥',
      '我在思考问题。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440026',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403409663&di=dedd3829d437cd3dbaf0eff35843aba6&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F0df3d7ca7bcb0a46e22496026063f6246b60af82.jpg',
      '忍者神龟',
      '忍者神龟。。。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440027',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403513811&di=9156b412a2d5e15cebe8f3b40a401bb9&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fwh%253D680%252C800%2Fsign%3D8b8e147a9b529822056631c5effa57f3%2F4afbfbedab64034fb55deabba4c379310b551dfe.jpg',
      '光头强',
      '我是光头强。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440028',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403568416&di=5ee437e92b9cbc9246035a6353fa8417&imgtype=0&src=http%3A%2F%2Fi6.qhimg.com%2Ft014810bec6c531fc18.jpg',
      '熊二',
      '俺是熊二。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440029',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403622653&di=35e4ad9d764d3ec3715693cd5508ebdf&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170628%2Fd1b92ad3de7b4078b23b419892ec255e_th.jpg',
      '超级飞侠',
      '超级飞侠。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440010',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403222736&di=7e55dcf50ed5ff2ad7db1303542aa71b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D71f82be767061d957d4637304bf60a5d%2Fdb7d15d8bc3eb135eb03e564af1ea8d3ff1f44a4.jpg',
      '大耳朵图图',
      '突然想到的',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440011',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403282649&di=c4f237332e6bf94546c950817699c2fd&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201504%2F11%2F20150411H0128_PHr4z.jpeg',
      '多拉a梦',
      '机器猫！！！',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440012',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403360209&di=ec25c22642ec5e3858dc70a393ca0697&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20110901%2FImg318072437.jpg',
      '一休哥',
      '我在思考问题。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440013',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403409663&di=dedd3829d437cd3dbaf0eff35843aba6&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F0df3d7ca7bcb0a46e22496026063f6246b60af82.jpg',
      '忍着神龟',
      '忍着神龟。。。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440015',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403513811&di=9156b412a2d5e15cebe8f3b40a401bb9&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fwh%253D680%252C800%2Fsign%3D8b8e147a9b529822056631c5effa57f3%2F4afbfbedab64034fb55deabba4c379310b551dfe.jpg',
      '光头强',
      '我是光头强。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440016',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403568416&di=5ee437e92b9cbc9246035a6353fa8417&imgtype=0&src=http%3A%2F%2Fi6.qhimg.com%2Ft014810bec6c531fc18.jpg',
      '熊二',
      '俺是熊二。。',
      new DateTime.now(),
      MessageType.CHAT
  ),
  new MessageData(
      'G2440017',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540403622653&di=35e4ad9d764d3ec3715693cd5508ebdf&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170628%2Fd1b92ad3de7b4078b23b419892ec255e_th.jpg',
      '超级飞侠',
      '超级飞侠。。',
      new DateTime.now(),
      MessageType.CHAT
  )
];