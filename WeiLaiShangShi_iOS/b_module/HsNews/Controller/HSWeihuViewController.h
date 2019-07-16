//
//  HSWeihuViewController.h
//  HSKD
//
//  Created by yuhao on 2019/4/18.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSWeihuViewController : UIViewController
- (instancetype)initWithurl:(NSString *)url comefrom:(NSString *)comeform;
- (instancetype)initWithhtmlstring:(NSString *)htmlstring comefrom:(NSString *)comeform;

@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *comeformtitle;
@property (nonatomic, strong)NSString *htmlstring;

@property(copy,nonatomic)NSString *orderCode;
@property(copy,nonatomic)NSString *payType;
@end

NS_ASSUME_NONNULL_END
