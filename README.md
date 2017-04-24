# Swift 3 图片浏览工具

[![License](https://img.shields.io/cocoapods/l/LLPhotoBrowser.svg?style=flat)](http://cocoapods.org/pods/LLPhotoBrowser)
[![Platform](https://img.shields.io/cocoapods/p/LLPhotoBrowser.svg?style=flat)](http://cocoapods.org/pods/LLPhotoBrowser)

## Support

* 支持识别二维码
* 支持网络图，本地图，UIImage同时使用
* 支持网络图片加载
* 支持图片放大缩小
* 支持双击放大指定位置
* 支持滑动查看及横屏切换图片
* 支持当前页/总页数显示
* 支持单击关闭
* 支持长按弹出功能窗口
* 支持自定义功能增加
* 支持图片数据的延时加载
* 支持没有数据，占位图占位
* 支持非物理横屏看图

## Demo

## <a id="二维码检测"></a>二维码检测
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/qrcode.gif" width="414" height="720">

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: data, currentIndex: indexPath.row, sheetTitileArray: ["分享给朋友","保存到相册"], isOpenQRCodeCheck: true) { (index, imageView, qrcodeString) in
  print("ActionSheet点击-->下标=\(index); ImageView:\(imageView); qrcodeString:\(String(describing: qrcodeString))")

  if let qrcode = qrcodeString {
    UIAlertView.init(title: "二维码地址", message: qrcode, delegate: self, cancelButtonTitle: "取消").show()
}
}
browser.presentBrowserViewController()
```

## <a id="图片正常浏览"></a>图片正常浏览
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/demo.gif" width="414" height="720">

## <a id="检测设备横屏"></a>检测设备横屏
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/landspace.gif" width="414" height="720">

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: data currentIndex: indexPath.row)
// 模态弹出
browser.presentBrowserViewController()
```

## <a id="Action Sheet"></a>Action Sheet
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/actionsheet.gif" width="414" height="720">

## <a id="检测设备横屏 Action Sheet"></a>检测设备横屏 Action Sheet
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/actionsheetlandspace.gif" width="414" height="720">

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: data, currentIndex: indexPath.row, sheetTitileArray: ["分享给朋友","保存到相册"]) { (index, imageView, qrcodeString) in
  print(index)
}
// 模态弹出
browser.presentBrowserViewController()
```

## Update
请使用最新版本 1.0.2

版本信息 | 更新描述
----    |  ------
1.0.2   | * 增加图片中二维码检测，目前仅支持单个链接二维码
1.0.1   | * 增加支持网络图，本地图，UIImage同时使用<br>* HTTPString, UIImage, 文件名称String
1.0.0   | * 项目初始化

## CocoaPods

- Add `pod "LLPhotoBrowser"` to your Podfile.
- Run `pod install` or `pod update`.
- import LLPhotoBrowser

## Usage
### 对象封装(见Demo里LLCollectionViewController.swift)
```swift
var data: [LLBrowserModel] = []
for index in 0..<bigUrlArray1_0_1.count {
  let cell: LLCollectionViewCell? = collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as? LLCollectionViewCell
  let model = LLBrowserModel.init()
  model.data = bigUrlArray1_0_1[index]
  if let c = cell {
    model.sourceImageView = c.ll_imageView
  }
  data.append(model)
}
```

### 简单的图片浏览

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: <#数组([LLBrowserModel])#>, currentIndex: <#当前索引(row)#>)
// 模态弹出
browser.presentBrowserViewController()
```

### 支持长按弹出AcitonSheet工具

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: <#数组([LLBrowserModel])#>, currentIndex: <#当前索引(row)#>, sheetTitileArray: <#工具菜单标题([String])#>) { (<#点击工具菜单下标#>, <#当前显示的imageView#>, <#二维码结果返回#>) in
  // 点击事件处理
  print("ActionSheet点击-->下标=\(index)")
}
// 模态弹出
browser.presentBrowserViewController()
```

### 支持类型，你可以这么玩1.0.1

```swift
/// 1.0.1版本 数据源
let bigUrlArray1_0_1: [Any?] = [ "http://car0.autoimg.cn/upload/spec/5900/1024x0_1_q87_2011071303265437981.jpg",
                                 // 文件名称
                                 "timg",
                                 "timg-1",
                                 // URL
                                 "http://img1a.xgo-img.com.cn/pics/2153/b2152556.jpg",
                                 "http://4493bz.1985t.com/uploads/allimg/140826/3-140R6142K1.jpg",
                                 // UIImage
                                 UIImage.init(named: "timg-5"),
                                 UIImage.init(named: "timg-7"),
                                 // URL
                                 "http://4493bz.1985t.com/uploads/allimg/140825/3-140R5115546.jpg"]
```

### 是否开启二维码检测1.0.2

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: data, currentIndex: indexPath.row, sheetTitileArray: ["分享给朋友","保存到相册"], isOpenQRCodeCheck: true) { (index, imageView, qrcodeString) in
  print("ActionSheet点击-->下标=\(index); ImageView:\(imageView); qrcodeString:\(String(describing: qrcodeString))")

  if let qrcode = qrcodeString {
    UIAlertView.init(title: "二维码地址", message: qrcode, delegate: self, cancelButtonTitle: "取消").show()
}
}
browser.presentBrowserViewController()
```

<!-- ## Future -->

## Example

示例代码见LLCollectionViewController.swift

## Issues
如果使用过程中，有什么问题欢迎issues。

## Author

LvJianfeng, coderjianfeng@foxmail.com
