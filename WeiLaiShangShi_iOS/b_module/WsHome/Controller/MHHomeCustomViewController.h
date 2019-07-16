//
//  MHHomeCustomViewController.h
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "MHBaseTableView.h"
@interface MHHomeCustomViewController : MHBaseViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *parentId;
@end
