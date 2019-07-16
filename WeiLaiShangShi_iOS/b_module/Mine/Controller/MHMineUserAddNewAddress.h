//
//  MHMineUserAddNewAddress.h
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
@class MHMineuserAddress;
@interface MHMineUserAddNewAddress : MHBaseViewController
@property (nonatomic, strong)MHMineuserAddress *adressModel;
@property (nonatomic, strong)UIButton *selelctBtn;
- (instancetype)initWithModel:(MHMineuserAddress *)adressModel;

@end
