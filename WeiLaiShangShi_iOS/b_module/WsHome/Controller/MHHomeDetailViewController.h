//
//  MHHomeDetailViewController.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHHomeDetailViewController : MHBaseViewController

- (instancetype)initWithId:(NSString *)activityId;

@property(copy,nonatomic)NSString *nameTitle;

@property(copy,nonatomic)NSString *colorStr;

@end
