//
//  MHMessageListViewController.h
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHMessageListViewController : MHBaseViewController
@property(nonatomic, strong)NSString *typeCode;
-(instancetype)initWithtypeCode:(NSString *)typeCode;
@end
