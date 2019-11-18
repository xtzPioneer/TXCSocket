# TXCSocket

[![CI Status](https://img.shields.io/travis/张雄/TXCSocket.svg?style=flat)](https://travis-ci.org/张雄/TXCSocket)
[![Version](https://img.shields.io/cocoapods/v/TXCSocket.svg?style=flat)](https://cocoapods.org/pods/TXCSocket)
[![License](https://img.shields.io/cocoapods/l/TXCSocket.svg?style=flat)](https://cocoapods.org/pods/TXCSocket)
[![Platform](https://img.shields.io/cocoapods/p/TXCSocket.svg?style=flat)](https://cocoapods.org/pods/TXCSocket)
## 介绍
统一管理服务器地址。可设置Run类型，在Release、DeBug模式中快速切换服务器地址。
## 运行示例

要运行示例项目，请克隆存储库，然后首先从Example目录运行`pod install`。

## 要求
iOS 8.0+
## 安装

可通过CocoaPods获得TXServerAddressManager。要安装它，只需将以下行添加到您的Podfile中：

```ruby
pod 'TXServerAddressManager'
```
## 使用姿势
### 配置环境
```objc
// 服务器地址管理
[TXServerAddressManager setServerAddressConfig:^(TXServerAddressConfig * _Nonnull serverAddressConfig) {
    serverAddressConfig.releaseServerAddressConfig.serverAddress = @"192.168.1.125";
    serverAddressConfig.releaseServerAddressConfig.serverPort = @"8080";
    serverAddressConfig.deBugServerAddressConfig.serverAddress = @"192.168.1.160";
    serverAddressConfig.deBugServerAddressConfig.serverAddress = @"9000";
}];
// 设置Run类型
[TXServerAddressManager setRunType:TXSARunTypeRelease];
```
### 使用说明
```objc
// 获取服务器地址
[TXServerAddressManager manager].serverAddress
// 获取服务器端口
[TXServerAddressManager manager].serverPort
```

## 作者












## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TXCSocket is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TXCSocket'
```

## Author

张雄, xtz_pioneer@163.com

## License

TXCSocket is available under the MIT license. See the LICENSE file for more info.
