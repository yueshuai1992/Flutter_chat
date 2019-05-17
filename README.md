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
