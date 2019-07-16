//
//  MHMessageManager.m
//  Stonedata
//
//  Created by yuhao on 2019/7/10.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHMessageManager.h"
#import <CommonCrypto/CommonHMAC.h>
/*
 * MQTTClient: imports
 * MQTTSessionManager.h is optional
 */
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>
@interface  MHMessageManager()<MQTTSessionManagerDelegate>
/*
 * MQTTClient: keep a strong reference to your MQTTSessionManager here
 */
@property (strong, nonatomic) MQTTSessionManager *manager;
@property (strong, nonatomic) NSDictionary *mqttSettings;
@property (strong, nonatomic) NSString *instanceId;
@property (strong, nonatomic) NSString *rootTopic;
@property (strong, nonatomic) NSString *accessKey;
@property (strong, nonatomic) NSString *secretKey;
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSString *clientId;
@property (nonatomic) NSInteger *qos;
@property (strong, nonatomic) NSString *topic;

@end

@implementation MHMessageManager
-(instancetype)initWithTopic:(NSString *)str
{
    self = [super init];
    if (self) {
        self.topic = str;
        [self createManag];
    }
    return self;
}
-(void)createManag
{
    //从配置文件导入相关属性
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSURL *mqttPlistUrl = [bundleURL URLByAppendingPathComponent:@"mqtt.plist"];
    self.mqttSettings = [NSDictionary dictionaryWithContentsOfURL:mqttPlistUrl];
    //实例 ID，购买后从控制台获取
    self.instanceId = self.mqttSettings[@"instanceId"];
    self.rootTopic = self.mqttSettings[@"rootTopic"];
    self.accessKey = self.mqttSettings[@"accessKey"];
    self.secretKey = self.mqttSettings[@"secretKey"];
    self.groupId = self.mqttSettings[@"groupId"];
    self.qos =[self.mqttSettings[@"qos"] integerValue];
    //cientId的生成必须遵循GroupID@@@前缀，且需要保证全局唯一
    self.clientId=[NSString stringWithFormat:@"%@@@@%@",self.groupId,@"DEVICE_002"];
    /*
     * MQTTClient: create an instance of MQTTSessionManager once and connect
     * will is set to let the broker indicate to other subscribers if the connection is lost
     */
    if (!self.manager) {
        self.manager = [[MQTTSessionManager alloc] init];
        self.manager.delegate = self;
        self.manager.subscriptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.qos]
                                                                 forKey:[NSString stringWithFormat:@"%@/newsTopic", self.rootTopic]];
        //password的计算方式是，使用secretkey对clientId做hmac签名算法，具体实现参考macSignWithText方法
        NSString *passWord = [[self class] macSignWithText:self.clientId secretKey:self.secretKey];
        NSString *userName = [NSString stringWithFormat:@"Signature|%@|%@",self.accessKey,self.instanceId];;
        //此处从配置文件导入的Host即为MQTT的接入点，该接入点获取方式请参考资源申请章节文档，在控制台上申请MQTT实例，每个实例会分配一个接入点域名
        [self.manager connectTo:self.mqttSettings[@"host"]
                           port:[self.mqttSettings[@"port"] intValue]
                            tls:[self.mqttSettings[@"tls"] boolValue]
                      keepalive:60  //心跳间隔不得大于120s
                          clean:true
                           auth:true
                           user:userName
                           pass:passWord
                           will:false
                      willTopic:nil
                        willMsg:nil
                        willQos:0
                 willRetainFlag:FALSE
                   withClientId:self.clientId];
    } else {
        [self.manager connectToLast];
    }
    
    /*
     * MQTTCLient: observe the MQTTSessionManager's state to display the connection status
     */
    
    [self.manager addObserver:self
                   forKeyPath:@"state"
                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                      context:nil];


}
+ (NSString *)macSignWithText:(NSString *)text secretKey:(NSString *)secretKey
{
    NSData *saltData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA1, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *base64Hash = [hash base64EncodedStringWithOptions:0];
    
    return base64Hash;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    switch (self.manager.state) {
        case MQTTSessionManagerStateClosed:
             MHLog(@"Closed");
//            self.status.text = @"closed";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateClosing:
             MHLog(@"Closing");
//            self.status.text = @"closing";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateConnected:
              MHLog(@"Connected");
//            self.status.text = [NSString stringWithFormat:@"connected as %@",
//                                self.clientId];
//            self.disconnect.enabled = true;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateConnecting:
            MHLog(@"Connecting");
//            self.status.text = @"connecting";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateError:
            MHLog(@"Error");
//            self.status.text = @"error";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateStarting:
            MHLog(@"Starting");
        default:
//            self.status.text = @"not connected";
//            self.disconnect.enabled = false;
//            self.connect.enabled = true;
            [self.manager connectToLast];
            break;
    }
}
/*
 * MQTTSessionManagerDelegate
 */
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    /*
     * MQTTClient: process received message
     */
 
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (self.getmsg) {
        self.getmsg(dataString, topic);
    }
  
}



@end
