//
//  MHBaseClass.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
#import "ZJAnimationPopView.h"
@interface MHBaseClass : NSObject

+ (MHBaseClass*)sharedInstance;

-(void)loginOut;

-(void)removeAppCatch;

-(NSUInteger)isErrorNetWork;


-(NSString *)createParamUrl:(NSString *)url param:(NSDictionary *)dict;

- (UIViewController *)getCurrentVC;
@property (nonatomic, strong)NSString *linkurl;
@property (nonatomic, strong)UIImageView *imge1;
@property (nonatomic, strong)UIImageView *imge2;
@property (nonatomic, strong)UIImageView *imge3;
@property (nonatomic, strong)UIImageView *close;
@property (nonatomic, strong) ZJAnimationPopView *popView;

//分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             title:(NSString *)title
                              desc:(NSString *)desc
                          shareUrl:(NSString *)shareUrl
             currentViewController:(UIViewController *)currentViewController
                           success:(void(^)(void))success
                          fail:(void(^)(void))fail;


#pragma mark 弹窗展现
-(void)presentAlertWithtitle:(NSString *)title message:(NSString *)message leftbutton:(NSString *)leftbutton rightbutton:(NSString *)rightbutton leftAct:(void(^)(void))leftAction rightAct:(void(^)(void))rightAction;

//公告展现
// 活动公告
-(void)presentActAltertWithtitle:(NSString *)title content:(NSString *)content backgroudImg:(NSString *)backgroudImg contentType:(NSString *)contentType closeImg:(NSString *)closeImg action_url:(NSString *)action_url type:(NSString *)type alertid:(NSString *)alertid;


@end
