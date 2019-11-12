//
//  TXCSocket.h
//  Pods-TXCSocket_Example
//
//  Created by 张雄 on 2019/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 错误代码 */
typedef NS_ENUM(NSInteger,TXCSocketErrorCode) {
    /** IP或Port错误 */
    TXCSocketErrorCodeIPOrPortError = -1000,
};

/** 连接成功回调 */
typedef void (^TXCSocketConnectionSuccessHandler) (NSString  * _Nonnull ip,uint16_t port);

/** 连接失败回调 */
typedef void (^TXCSocketConnectionFailureHandler) (NSError * _Nonnull error);

/** 读取数据回调 */
typedef void (^TXCSocketReadDataHandler) (NSData * _Nonnull data,long tag);

/** 发送成功回调 */
typedef void (^TXCSocketSendSuccessHandler) (long tag);

/**
 *  基于‘CocoaAsyncSocket’所开发的客户端Socket
 */
@interface TXCSocket : NSObject

/** 服务器地址 */
@property (nonatomic,copy)NSString *ip;

/** 服务器端口 */
@property (nonatomic,assign)uint16_t port;

/**
 *  连接超时时间
 *
 *  说明:默认为-1,永不超时
 *
 */
@property (nonatomic,assign)NSTimeInterval connectionTimeout;

/**
 *  发送数据超时时间
 *
 *  说明:默认为-1,永不超时
 *
 */
@property (nonatomic,assign)NSTimeInterval sendDataTimeout;

/**
 *  读取数据超时时间
 *
 *  说明:默认为-1,永不超时
 *
 */
@property (nonatomic,assign)NSTimeInterval readDataTimeout;

/** 是否连接 */
@property (nonatomic,assign,readonly)BOOL isConnection;

/** 连接成功回调 */
@property (nonatomic,copy)TXCSocketConnectionSuccessHandler connectionSuccessHandler;

/** 连接失败回调 */
@property (nonatomic,copy)TXCSocketConnectionFailureHandler connectionFailureHandler;

/** 读取数据回调 */
@property (nonatomic,copy)TXCSocketReadDataHandler readDataHandler;

/** 发送成功回调 */
@property (nonatomic,copy)TXCSocketSendSuccessHandler sendSuccessHandler;

/** 连接 */
- (void)connection;

/** 断开连接 */
- (void)disconnect;

/**
 *  发送数据
 *
 *  @param data 数据
 *  @param tag 标签
 *
 */
- (void)send:(NSData * _Nonnull)data tag:(long)tag;

/** 快速构建客户端Socket */
+ (instancetype)socket;

// 禁止使用下面方法创建对象
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)copy NS_UNAVAILABLE;
- (instancetype)mutableCopy NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
