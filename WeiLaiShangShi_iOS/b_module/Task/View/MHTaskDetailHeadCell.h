//
//  MHTaskDetailHeadCell.h
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^saveact)(void);
@interface MHTaskDetailHeadCell : UITableViewCell
@property(nonatomic, copy)saveact SaveAct ;
@property(nonatomic, strong)UILabel *headtitle;
@property(nonatomic, strong)UIView *lineview;
@property(nonatomic, strong)UILabel *savePic;
@end
