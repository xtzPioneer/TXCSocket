# TXCSocket

[![CI Status](https://img.shields.io/travis/张雄/TXCSocket.svg?style=flat)](https://travis-ci.org/张雄/TXCSocket)
[![Version](https://img.shields.io/cocoapods/v/TXCSocket.svg?style=flat)](https://cocoapods.org/pods/TXCSocket)
[![License](https://img.shields.io/cocoapods/l/TXCSocket.svg?style=flat)](https://cocoapods.org/pods/TXCSocket)
[![Platform](https://img.shields.io/cocoapods/p/TXCSocket.svg?style=flat)](https://cocoapods.org/pods/TXCSocket)

## 介绍

基于‘CocoaAsyncSocket’所开发的客户端Socket。

## 运行示例

要运行示例项目，请克隆存储库，然后首先从Example目录运行`pod install`。

## 要求

iOS 8.0+

## 安装

可通过CocoaPods获得TXCSocket。要安装它，只需将以下行添加到您的Podfile中：

```ruby
pod 'TXCSocket'
```

## 使用姿势
```objc
// 构建客户端Socket
self.socket= [TXCSocket socket];
// 设置IP
self.socket.ip = @"192.168.2.14";
// 设置端口
self.socket.port = 3991;
// 连接成功回调
self.socket.connectionSuccessHandler = ^(NSString * _Nonnull ip, uint16_t port) {
    NSLog(@"连接成功");
};
// 连接失败回调
self.socket.connectionFailureHandler = ^(NSError * _Nonnull error) {
    NSLog(@"连接失败");
};
// 连接
[self.socket connection];
```

## 作者

张雄, xtz_pioneer@163.com

## 许可

TXCSocket在MIT许可下可用。有关更多信息，请参见LICENSE文件。
