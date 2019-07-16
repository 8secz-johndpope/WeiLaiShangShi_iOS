//
//  MHHomeCategory.h
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "MHBaseTableView.h"


@interface MHHomeCategory : MHBaseViewController
- (instancetype)initWithTypeId:(NSString *)typeId;
@property (nonatomic, strong) MHBaseTableView *tableView;

@end
