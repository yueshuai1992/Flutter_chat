## 主要展示了以下功能
   - 消息列表展示
   - 发送文字
   - 发送图片
   - 发送语音
   - 发送表情
   - 聊天图片放大预览
   - 页面的基本布局
   - 扫描二维码
   - 二维码展示
   - webView网页的访问
   - 打开微信小程序
   - 人脉列表展示
```
   聊天部分使用web_socket 和 http 图片/语音上传。
   socket 服务该github chat_socket
   http 语音上传该github file_upload
```
## 项目名字为
   xz_address_list 通讯录APP

## Getting Started

- 打包apk
    flutter build apk

- 扫码修改：（barcodescan的位置）
```
    /Users/mac/development/flutter/.pub-cache/hosted/pub.dartlang.org/barcode_scan-1.0.0/android/src/main/kotlin/com/apptreesoftware/barcodescan/BarcodeScannerActivity.kt

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        if (scannerView.flash) {
            val item = menu.add(0,
                    TOGGLE_FLASH, 0, "关闭灯光")
            item.setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS)
        } else {
            val item = menu.add(0,
                    TOGGLE_FLASH, 0, "打开灯光")
            item.setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS)
        }
        return super.onCreateOptionsMenu(menu)
    }
```
### 本人是一个前端工程师，对iOS和安卓了解不够健全，包括flutter也是实验项目，希望给路过的您带来帮助。该项目使用了大量flutter社区提供的package文件，和参考了他人项目，得到了很大的收获，如有权益问题请及时联系。谢谢！
