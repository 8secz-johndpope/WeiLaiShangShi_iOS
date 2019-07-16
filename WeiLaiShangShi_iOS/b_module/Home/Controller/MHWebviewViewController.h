//
//  MHWebviewViewController.h
//  mohu
//
//  Created by yuhao on 2018/10/18.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHWebviewViewController : MHBaseViewController
- (instancetype)initWithurl:(NSString *)url comefrom:(NSString *)comeform;
- (instancetype)initWithhtmlstring:(NSString *)htmlstring comefrom:(NSString *)comeform;

@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *comeformtitle;
@property (nonatomic, strong)NSString *htmlstring;

@property(copy,nonatomic)NSString *orderCode;
@property(copy,nonatomic)NSString *payType;
@end
