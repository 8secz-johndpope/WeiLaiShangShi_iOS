//
//  MHMineUserInfoViewController.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"



@interface MHMineUserInfoViewController : MHBaseViewController
@property(nonatomic, strong)NSMutableDictionary *dic;
- (instancetype)initWithModel:(NSMutableDictionary *)userInfo;
@property(nonatomic, strong)UIButton *loginout;
@end
