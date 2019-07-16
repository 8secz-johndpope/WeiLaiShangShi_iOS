//
//  MHWechatYQVC.h
//  mohu
//
//  Created by AllenQin on 2018/10/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHWechatYQVC : MHBaseViewController


@property(copy,nonatomic) NSString *phone;
@property(copy,nonatomic) NSString *smsCode;
@property(copy,nonatomic) NSString *uid;
@property(copy,nonatomic) NSString *unionid;
@property(copy,nonatomic) NSString *thirdparty;


@end

NS_ASSUME_NONNULL_END
