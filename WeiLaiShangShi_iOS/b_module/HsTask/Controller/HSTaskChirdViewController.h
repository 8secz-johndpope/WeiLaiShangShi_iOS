//
//  HSTaskChirdViewController.h
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "SGPagingViewPopGestureVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSTaskChirdViewController : MHBaseViewController

@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSString *type;
@end

NS_ASSUME_NONNULL_END
