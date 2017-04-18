# LLPhotoBrowser
swift 3 图片浏览

## Issues
如果使用过程中，有什么问题欢迎issues。

## Support

* 支持网络图片加载
* 支持滑动查看
* 支持当前页/总页数显示
* 支持单击关闭
* 支持图片数据的延时加载
* 支持没有数据，占位图占位
* 支持非物理横屏看图

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

## Author

LvJianfeng, coderjianfeng@foxmail.com
