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
@property (nonatomic,strong)NSMutableDictionary *sockets;
@property (nonatomic,assign)int sNumbers;
@property (nonatomic,assign)int fNumbers;
@end

@implementation TXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sockets = [NSMutableDictionary dictionary];
    self.sNumbers = 0;
    self.sNumbers = 0;
    __weak typeof(self) weakSelf = self;
    for (int index = 0; index<10; index++) {
        [NSThread sleepForTimeInterval:1];
        TXCSocket *socket = [TXCSocket socket];
        socket.ip = @"192.168.2.14";
        socket.port = 3991;
        __weak typeof(socket) weakSocket = socket;
        socket.connectionSuccessHandler = ^(NSString * _Nonnull ip, uint16_t port) {
            weakSelf.sNumbers += 1;
            NSString * userId=@"0026fcb93216446da20258539eba4ba2";
            NSString * token=@"dc477dc7e6e74fc6a62aa2d64cf754ac";
            NSDictionary *regDict = @{@"ctrl":@"REG",@"user":userId,@"token":token};
            NSString *regStr =[weakSelf JSONStringWithDic:regDict];
            regStr = [regStr stringByAppendingString:@"@"];
            [weakSocket send:[regStr dataUsingEncoding:NSUTF8StringEncoding] tag:0];
            NSLog(@"连接成功数量:%d",weakSelf.sNumbers);
        };
        socket.connectionFailureHandler = ^(NSError * _Nonnull error) {
            weakSelf.fNumbers += 1;
            NSLog(@"------>连接失败数量:%d",weakSelf.fNumbers);
        };
        [socket connection];
        [self.sockets setValue:socket forKey:[NSString stringWithFormat:@"%d",index]];
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)JSONStringWithDic:(NSDictionary*)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
