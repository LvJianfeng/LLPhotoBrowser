# LLPhotoBrowser
### Swift 3 图片浏览工具

## Support

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

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: data currentIndex: indexPath.row)
// 模态弹出
browser.presentBrowserViewController()
```

## <a id="图片正常浏览"></a>图片正常浏览
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/demo.gif" width="414" height="720">

## <a id="检测设备横屏"></a>检测设备横屏
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/landspace.gif" width="414" height="720">

```swift
let browser = LLPhotoBrowserViewController.init(photoArray: data, currentIndex: indexPath.row, sheetTitileArray: ["分享给朋友","保存到相册"]) { (index) in
  print(index)
}
// 模态弹出
browser.presentBrowserViewController()
```

## <a id="Action Sheet"></a>Action Sheet
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/actionsheet.gif" width="414" height="720">

## <a id="检测设备横屏 Action Sheet"></a>检测设备横屏 Action Sheet
<img src="https://github.com/LvJianfeng/LLPhotoBrowser/blob/master/actionsheetlandspace.gif" width="414" height="720">


## Update
请使用最新版本 1.0.0

版本信息 | 更新描述
----    |  ------
1.0.0   | * 项目初始化


## Usage
```swift
let browser = LLPhotoBrowserViewController.init(photoArray: <#LLBrowserModel#>, currentIndex: <#row#>)
// 模态弹出
browser.presentBrowserViewController()
```

## Example

示例代码见LLCollectionViewController.swift

## Future

* 支持cocoapod管理
* 支持本地图片显示及与网络图的混合显示
* 支持系统UIPageControl位置设置

## Issues
如果使用过程中，有什么问题欢迎issues。

## Author

LvJianfeng, coderjianfeng@foxmail.com
