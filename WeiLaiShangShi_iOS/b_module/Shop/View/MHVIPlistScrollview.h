//
//  MHVIPlistScrollview.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUTableView.h"

@interface MHVIPlistScrollview : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray *arrData;
@property (nonatomic, assign)NSInteger rowIndex;
@property (nonatomic, strong)SUTableView *tableView;
@property (nonatomic, strong)NSTimer *timer;

-(id)initWithFrame:(CGRect)frame array:(NSArray*)array;

/**
 *  启动定时器开始滚动
 */
- (void)createTimer;

/**
 *  界面消失停止定时器，否则会导致内存泄露
 */
- (void)stopTimer;


@end
