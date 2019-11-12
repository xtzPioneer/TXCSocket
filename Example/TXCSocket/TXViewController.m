//
//  TXViewController.m
//  TXCSocket
//
//  Created by 张雄 on 11/12/2019.
//  Copyright (c) 2019 张雄. All rights reserved.
//

#import "TXViewController.h"
#import "TXCSocket.h"

@interface TXViewController ()

/** 客户端Socket */
@property (nonatomic,strong)TXCSocket *socket;

@end

@implementation TXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
