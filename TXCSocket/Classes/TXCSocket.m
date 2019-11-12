//
//  TXCSocket.m
//  Pods-TXCSocket_Example
//
//  Created by 张雄 on 2019/11/12.
//

#import "TXCSocket.h"
#import "GCDAsyncSocket.h"

@interface TXCSocket () <GCDAsyncSocketDelegate>

/** Socket的串行队列 */
@property (nonatomic,strong)dispatch_queue_t socketQueue;

/** 发送的串行队列 */
@property (nonatomic,strong)dispatch_queue_t sendQueue;

/** 反馈的串行队列 */
@property (nonatomic,strong)dispatch_queue_t feedbackQueue;

/** GCDAsyncSocket */
@property (nonatomic,strong)GCDAsyncSocket *aSocket;

/** 是否连接 */
@property (nonatomic,assign,readwrite)BOOL isConnection;

@end

@implementation TXCSocket

/** 快速构建客户端Socket */
+ (instancetype)socket {
    return [[self alloc] init];
}

/** 初始化 */
- (instancetype)init {
    if (self = [super init]) {
        self.socketQueue = dispatch_queue_create("com.socket.socketQueue", DISPATCH_QUEUE_SERIAL);
        self.sendQueue = dispatch_queue_create("com.socket.sendQueue", DISPATCH_QUEUE_SERIAL);
        self.feedbackQueue = dispatch_queue_create("com.socket.feedbackQueue", DISPATCH_QUEUE_SERIAL);
        self.aSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:self.socketQueue];
        self.connectionTimeout = -1;
        self.sendDataTimeout = -1;
        self.readDataTimeout = -1;
    }
    return self;
}

/** 是否连接 */
- (BOOL)isConnection {
    return self.aSocket.isConnected;
}

/** 连接 */
- (void)connection {
    NSError *error = nil;
    if (self.ip && self.ip.length > 0 && self.port) {
        if (self.isConnection) [self disconnect];
        [self.aSocket connectToHost:self.ip onPort:self.port withTimeout:self.connectionTimeout error:&error];
    }else {
        NSString *message = @"IP或Port错误!";
        error = [NSError errorWithDomain:@"ConnectionFailure" code:TXCSocketConnectionFailureErrorCodeIPOrPortError userInfo:@{@"message":message}];
        if (self.connectionFailureHandler) self.connectionFailureHandler(error);
    }
}

/** 断开连接 */
- (void)disconnect {
    [self.aSocket disconnect];
}

/**
 *  发送数据
 *
 *  @param data 数据
 *  @param tag 标签
 *
 */
- (void)send:(NSData * _Nonnull)data tag:(long)tag {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.sendQueue, ^{
        if (weakSelf.aSocket.isConnected) [weakSelf.aSocket writeData:data withTimeout:weakSelf.sendDataTimeout tag:tag];
    });
}

/** 发送成功 */
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.feedbackQueue, ^{
        [weakSelf.aSocket readDataWithTimeout:weakSelf.readDataTimeout tag:tag];
        if (weakSelf.sendSuccessHandler) weakSelf.sendSuccessHandler(tag);
    });
}

/** 连接成功 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.feedbackQueue, ^{
        if (weakSelf.connectionSuccessHandler) weakSelf.connectionSuccessHandler(host, port);
    });
}

/** 连接失败 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err {
    __weak typeof(self) weakSelf = self;
    dispatch_async(weakSelf.feedbackQueue, ^{
        if (weakSelf.connectionFailureHandler) weakSelf.connectionFailureHandler(err);
    });
}

/** 读取到数据 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    __weak typeof(self) weakSelf = self;
    dispatch_async(weakSelf.feedbackQueue, ^{
        if (weakSelf.readDataHandler) weakSelf.readDataHandler(data,tag);
    });
}

@end
