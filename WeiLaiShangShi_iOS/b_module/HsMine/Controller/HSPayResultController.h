//
//  HSPayResultController.h
//  HSKD
//
//  Created by AllenQin on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSPayResultController : MHBaseViewController

@property(copy,nonatomic)NSString *orderCode;

@property(copy,nonatomic)NSString *payType;


-(void)showError;


@end

NS_ASSUME_NONNULL_END
